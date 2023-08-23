import 'dart:convert';


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/toast.dart';


class BookingController extends GetxController{





  var PaymentId="".obs;
  updatePaymentId(val){
    PaymentId.value=val;
    update();
  }

  var bookId="".obs;
  updateBookId(val){
    bookId.value=val;
    update();
  }







  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);

      if (paymentIntentData != null) {
        var gPay= const PaymentSheetGooglePay(
            merchantCountryCode: "usd",
            currencyCode: "usd",
            testEnv: true
        );
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: 'Ikay',
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
                googlePay: gPay
            ));

        print(paymentIntentData);

        displayPaymentSheet(totalFee: amount);

      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }


  displayPaymentSheet({totalFee}) async {
    try {
      Get.put(UserController()).updateAddBookLoader(false);
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentIntentData = null;
        flutterToastSuccess(msg: "Payment Success");
        Get.put(UserController()).updateAddBookLoader(true);

         ApiManger().confirmBooking();


      }).onError((error, stackTrace) {
        Get.put(UserController()).updateAddBookLoader(false);
        print("Payment Declined");
        flutterToast(msg: "Payment Declined");
        throw Exception(error);

      });
    } on StripeException catch (e) {
      Get.put(UserController()).updateAddBookLoader(false);
      print("Payment Declined");
      flutterToast(msg: "Payment Declined");
      print('Error is:---> $e');

    } catch (e) {
      Get.put(UserController()).updateAddBookLoader(false);
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer ${dotenv.env['STRIPE_SECRET']}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(response.body);
      if(response.statusCode==200){
        var jsonString=jsonDecode(response.body);
        print("This is respnonse");
        print(jsonString["id"].toString());
        updatePaymentId(jsonString["id"].toString());
        print(response.body);
        Get.put(UserController()).updateAddBookLoader(false);

        return jsonDecode(response.body);

      }
      else{
        Get.put(UserController()).updateAddBookLoader(false);
        return jsonDecode(response.body);
      }


    } catch (err) {
      Get.put(UserController()).updateAddBookLoader(false);
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    print(a);
    return a.toString();
  }
}