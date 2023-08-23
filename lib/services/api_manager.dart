import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/complete_profile.dart';
import 'package:stylish_app/app_module/authentication/forget/view/new_password.dart';
import 'package:stylish_app/app_module/authentication/login.dart';
import 'package:stylish_app/app_module/authentication/model/resend_model.dart';
import 'package:stylish_app/app_module/authentication/model/services_model.dart';
import 'package:stylish_app/app_module/authentication/otp.dart';
import 'package:stylish_app/app_module/stylish_home/controller/stylish_controller.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_booking/model/order.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_booking/model/orrder_model.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_profile/model/stylish_payment.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_profile/model/time_model.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_profile/model/update.dart';
import 'package:stylish_app/app_module/stylish_home/view/stylish_home.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/controller/booking_controller.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/model/orrder_model.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/profile/model/get_profile_model.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/profile/model/payment_model.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/user_dashboard/model/category_model.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/app_module/user_home/view/user_home.dart';
import 'package:stylish_app/util/constant.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/helper_function.dart';

class ApiManger extends GetConnect {
  static var client = http.Client();

  static Uri uriPath({required String nameUrl}) {
    print("Url: ${AppConstants.baseURL}$nameUrl");
    return Uri.parse(AppConstants.baseURL + nameUrl);
  }

  loginResponse({required BuildContext context, token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email':Get.put(AuthController()).emailController.text,
        'password': Get.put(AuthController()).passController.text,
        'type': "client",
        'device_token': token,

      });
      print(data.fields);
      print(data.fields);
      var response =
          await dio.Dio().post(AppConstants.baseURL + AppConstants.login,
              data: data,
              options: dio.Options(headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              }));
      print(data);

      if (response.statusCode == 200) {

        HelperFunctions.saveInPreference(
            "id", response.data['data']['id'].toString());
        HelperFunctions.saveInPreference(
            "userToken", response.data['token'].toString());
        HelperFunctions.saveInPreference(
            "userType",
            response.data['data']['type'].toString());
        HelperFunctions.saveInPreference(
            "image",
            response.data['data']['image']==null?"":
            response.data['data']['image'].toString());

        HelperFunctions.saveInPreference(
            "name", response.data['data']['first_name'].toString());
        HelperFunctions.saveInPreference(
            "last", response.data['data']['last_name'].toString());
        HelperFunctions.saveInPreference(
            "email", response.data['data']['email'].toString());
        HelperFunctions.saveInPreference(
            "phone", response.data['data']['phone'].toString());
        HelperFunctions.saveInPreference(
            "address", response.data['data']['address'].toString());
        HelperFunctions.saveInPreference(
            "code",
            response.data['data']['post_code']==null?"":
            response.data['data']['post_code'].toString());
        if(response.data['data']['type']=="client"){
          Get.offAll(() => UserHome(), transition: Transition.cupertinoDialog);
        }
        else{
           Get.offAll(() => StylishHome(), transition: Transition.cupertinoDialog);
        }

        Get.put(AuthController()).updateLoginLoader(false);

      }
      if (response.statusCode == 202) {
        print("response.statusCode");
        print(response.data);

        if(response.data["message"]=="Please verify your email address first"){

          verifyCodeAgain(token:response.data["token"],email:response.data["data"]["email"],id: response.data["data"]["id"].toString(),
          type: response.data["data"]["type"]
          );

        }
        else if(response.data["message"]=="Please add your information first."){
          flutterToast(msg:"Please add your information first" );
          Get.put(AuthController()).updateLoginLoader(false);
          Get.to(CompleteProfile(token:response.data["token"] ,));

        }

        else if(response.data["message"]=="You signup request is pending for approval"){
          flutterToastLong(msg:"You signup request is pending for approval" );
          Get.put(AuthController()).updateLoginLoader(false);

        }
        else{
          print(response.data);
          Get.put(AuthController()).updateLoginLoader(false);
          flutterToast(msg: response.data.toString());
        }


      }
    } on dio.DioError catch (e) {
      print(e.response?.data);
      Get.put(AuthController()).updateLoginLoader(false);

      print(e.response?.statusCode);
      flutterToast(msg: e.response?.data["message"]);
      log("e.response");
      log(e.response.toString());
    }
  }

  //...........Verify Resend Code.........................

   Future<ResendModel?> verifyCodeAgain(
      {var id, token,email,type}) async {
    var response = await client
        .get(uriPath(nameUrl: "${AppConstants.resend}?id=${id.toString()}"),
        headers: {
          // HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.toString()}"

        }
    );
    print(response.toString());
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      flutterToast(msg: "Please verify email addresses");
      print(response.body);

      Get.to(OtpScreen(id: id.toString(),email: email.toString(),token: token.toString(),type: type.toString(),));

      Get.put(AuthController()).updateLoginLoader(false);
      return resendModelFromJson(response.body);
    } else if (response.statusCode == 202) {
      print(response.body);
      Get.put(AuthController()).updateLoginLoader(false);
      return resendModelFromJson(response.body);
    }
    return null;
  }


  registerResponse({required BuildContext context, token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'first_name': Get.put(AuthController()).fullNameController.text,
        'last_name': Get.put(AuthController()).lastNameController.text,
        'type': Get.put(AuthController()).userType.value.toString(),
        'email':Get.put(AuthController()).emailRegController.text,
        'phone': Get.put(AuthController()).phoneController.text,
        'password': Get.put(AuthController()).passRegController.text,
        'confirm_password': Get.put(AuthController()).passRegController.text,
        'address': Get.put(AuthController()).addressController.text,
        'post_code': Get.put(AuthController()).postalController.text,
        'device_token': token,
        'lat': Get.put(AuthController()).lat.value,
        'long': Get.put(AuthController()).lng.value,
      });
      print(data.fields);
      print(data.fields);
      var response =
      await dio.Dio().post(AppConstants.baseURL + AppConstants.register,
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      print(data);

      if (response.statusCode == 200) {

        print(response.data);
        flutterToast(msg: "Please verify your email address");
        Get.to(OtpScreen(id: response.data["data"]["id"].toString(),token:response.data["token"],
        email:response.data["data"]["email"].toString() ,
          type:response.data["data"]["type"].toString() ,
        ));
        print("response.statusCode");
        Get.put(AuthController()).updateLoader(false);

      }
      if (response.statusCode == 202) {
        print("response.statusCode");
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: response.data["error"].toString());
      }
    } on dio.DioError catch (e) {
      print("response.statusCode");
      Get.put(AuthController()).updateLoader(false);

      print(e.response?.statusCode);
      flutterToast(msg: e.response?.data["error"]);
      log("e.response");
      log(e.response.toString());
    }
  }


  otpResponse({required BuildContext context, id, token,otp,String apiNames="",typeName="",
  String fieldName=""
  }) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'id': id.toString(),
        fieldName: otp.toString(),

      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + apiNames,
        data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${token.toString()}"

          }
      ));
      print(AppConstants.baseURL + apiNames);
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        if(typeName=="forget"){
          Get.put(AuthController()).updateOtp(false);
          flutterToastSuccess(msg: "Please create new password");
          Get.off(NewPassword(id: response.data["data"]["id"].toString(),));
        }
        else if(typeName=="stylist"){

          flutterToastSuccess(msg: "Please complete Your Profile");
          Get.put(AuthController()).updateOtp(false);
          Get.off(CompleteProfile(token: token.toString(),));
        }

        else{
          Get.put(AuthController()).updateOtp(false);
          flutterToastSuccess(msg: "Account Created Successfully");
          Get.put(AuthController()).clear();
          Get.put(AuthController()).clearCompleteProfile();
          Get.put(AuthController()).clearLogin();
          Get.offAll(LoginView());
        }



      }
      if (response.statusCode == 202) {
        print(response.data);
        Get.put(AuthController()).updateOtp(false);
        flutterToast(msg: response.data["error"].toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateOtp(false);
      print(e.response?.data);
      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }




  //...........Resend Code.........................

  static Future<ResendModel?> resendResponse(
      {var id, required BuildContext context,token,String apiName=""}) async {
    var response = await client
        .get(uriPath(nameUrl: "$apiName?id=${id.toString()}"),
        headers: {
          // HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token.toString()}"

        }
    );

    if (response.statusCode == 200) {
      flutterToastSuccess(msg: "Code resent successfully");

      Get.put(AuthController()).updateResendOtp(false);
      return resendModelFromJson(response.body);
    } else if (response.statusCode == 202) {
      Get.put(AuthController()).updateResendOtp(false);
      return null;
    }
    return null;
  }


  forgetResponse({context, email}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email,
      });
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.forget,
        data: data,
      );
      if (response.statusCode == 200) {

        Get.put(AuthController()).updateForgetLoader(false);
        Get.to(OtpScreen(id: response.data["id"].toString(),token:"",
          email: email,
          type: "forget",
        ));


        flutterToast(msg: "Successfully Code Sent");
      }
      else if(response.statusCode==202){
        flutterToast(msg: response.data["error"].toString());
        Get.put(AuthController()).updateForgetLoader(false);
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateForgetLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }
  //...........Change Password.........................

  changePassResponse({ context, id, password}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'id': id.toString(),
        'password': password,
        'confirm_password': password,
      });
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.resetPassword,
        data: data,
      );
      if (response.statusCode == 200) {
        flutterToastSuccess(msg: "Password reset successfully");
        Get.offAll(LoginView());
        Get.put(AuthController()).updatePasswordLoader(false);
        Get.put(AuthController()).clear();
        Get.put(AuthController()).clearCompleteProfile();
        Get.put(AuthController()).clearLogin();



      }
      else if (response.statusCode == 202) {



        Get.put(AuthController()).updatePasswordLoader(false);
        flutterToast(msg: response.data["error"].toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updatePasswordLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());

    }
  }


  static Future<ServicesModel?> getServiceAll({search="",String ?cat}) async {
    var response = await client.get(uriPath(nameUrl: "${AppConstants.getService}?search=${search.toString()}&category_id=${cat==null?0:cat.toString()}"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",

        });
    debugPrint("response.statusCode");
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      return ServicesModel.fromJson(jsonString);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }





  static Future<AllCategories?> allCat() async {
    var response = await client.get(uriPath(nameUrl: AppConstants.category),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",

        });
    debugPrint("response.statusCode");
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      return AllCategories.fromJson(jsonString);
    } else {
      debugPrint(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  createProfile({
    var gender,
    var situation,
    var far,
    var hear,
    var token,
    required BuildContext context,

  }) async {
    try {
      try {
        dio.FormData data = dio.FormData.fromMap({
          'gender': gender.toString(),
          'how far': far.toString(),
          'current_situation': situation.toString(),
          'hear': hear.toString(),

          Get.put(AuthController()).fileCnic==null?"":

          'cnic[0]':

          Get.put(AuthController()).fileCnic==null?"":


          await dio.MultipartFile.fromFile(
              Get.put(AuthController()).fileCnic!.path),

          Get.put(AuthController()).fileCnic==null?"":
          'cnic[1]':
          Get.put(AuthController()).fileCnic==null?"":
          await dio.MultipartFile.fromFile(
              Get.put(AuthController()).fileCnic!.path),
          Get.put(AuthController()).fileInsurance==null?"":
          'insurance':
          Get.put(AuthController()).fileInsurance==null?"":

          await dio.MultipartFile.fromFile(
              Get.put(AuthController()).fileInsurance!.path),
          Get.put(AuthController()).fileCv==null?"":
          'cv':
          Get.put(AuthController()).fileCv==null?"":

          await dio.MultipartFile.fromFile(
              Get.put(AuthController()).fileCv!.path),
          Get.put(AuthController()).fileDb==null?"":
          'dbs':
          Get.put(AuthController()).fileDb==null?"":

          await dio.MultipartFile.fromFile(
              Get.put(AuthController()).fileDb!.path),
         // 'services':Get.put(AuthController()).selectIndex


        });
        if (Get.put(AuthController()).selectIndex.isNotEmpty) {
          for (int i = 0; i <Get.put(AuthController()).selectIndex.length; i++) {
            data.fields
                .add(MapEntry('services[$i]', Get.put(AuthController()).selectIndex[i].toString()));
          }
        }
        print(data.fields);
        print(data.fields);
        var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.stylishAdd,
          data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${token.toString()}"

            }
            ));
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.offAll(LoginView());
          Get.put(AuthController()).updateComplete(false);
          flutterToast(msg: "Account Created, Please wait for admin approval");

          Get.put(AuthController()).clear();
          Get.put(AuthController()).clearCompleteProfile();
          Get.put(AuthController()).clearLogin();
          print(response.data);
        } else if (response.statusCode == 202) {
          Get.put(AuthController()).updateComplete(false);

          flutterToast(msg: response.data.toString());
        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateComplete(false);
        print(e.response?.data);
        flutterToast(msg: e.response?.data.toString());

      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateComplete(false);
      flutterToast(msg: e.response?.data.toString());
      print(e.response?.data);
    }
  }


  //...........Edit Profile.........................

  editProfileResponse({context, token}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'first_name': Get.find<AuthController>().fullNameController.text,
          'last_name':Get.find<AuthController>().lastNameController.text,
          'email': Get.find<UserController>().email.value,
          'phone': Get.find<AuthController>().phoneController.text,
          'address': Get.find<AuthController>().addressController.text,
          'post_code':Get.find<AuthController>().postalController.text,
          'lat': Get.put(AuthController()).lat.value,
          'long': Get.put(AuthController()).lng.value,
          Get.put(UserController()).file == null ? "" : 'image':
          Get.put(UserController()).file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(UserController()).file!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        print(AppConstants.baseURL + AppConstants.updateProfile);
        print(AppConstants.baseURL + AppConstants.updateProfile);
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.updateProfile,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value.toString()}"


            }
            ));

        if (response.statusCode == 200) {
          Get.put(UserController()).getProfileData();
          Get.put(AuthController()).updateLoader(false);
          HelperFunctions.saveInPreference("name",
              response.data["data"]['first_name'].toString());
          Get.put(UserController()).updateFirstName(
              response.data["data"]['first_name'].toString());

          HelperFunctions.saveInPreference("last",
              response.data["data"]['last_name'].toString());
          Get.put(UserController()).updateLast(
              response.data["data"]['last_name'].toString());



          Get.back();
          flutterToastSuccess(msg: "Profile Update Successfully");
        }
        else if (response.statusCode == 202) {
          Get.put(AuthController()).updateLoader(false);

          flutterToast(msg: response.data.toString());
        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: e.response?.data.toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      flutterToast(msg: e.response?.data.toString());
      log(e.toString());
    }
  }




  //...........Edit Profile.........................

  editProfileResponse1({context, token}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'first_name': Get.find<AuthController>().fullNameController.text,
          'last_name':Get.find<AuthController>().lastNameController.text,
          'email': Get.find<StylishController>().email.value,
          'phone': Get.find<AuthController>().phoneController.text,
          'address': Get.find<AuthController>().addressController.text,
          'post_code':Get.find<AuthController>().postalController.text,
          'lat': Get.put(AuthController()).lat.value,
          'long': Get.put(AuthController()).lng.value,
          Get.put(StylishController()).file == null ? "" : 'image':
          Get.put(StylishController()).file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(StylishController()).file!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        print(AppConstants.baseURL + AppConstants.updateProfile);
        print(AppConstants.baseURL + AppConstants.updateProfile);
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.updateProfile,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value.toString()}"


            }
            ));

        if (response.statusCode == 200) {
          Get.put(StylishController()).getProfileData();
          Get.put(AuthController()).updateLoader(false);
          HelperFunctions.saveInPreference("name",
              response.data["data"]['first_name'].toString());
          Get.put(StylishController()).updateFirstName(
              response.data["data"]['first_name'].toString());

          HelperFunctions.saveInPreference("last",
              response.data["data"]['last_name'].toString());
          Get.put(StylishController()).updateLast(
              response.data["data"]['last_name'].toString());



          Get.back();
          flutterToastSuccess(msg: "Profile Update Successfully");
        }
        else if (response.statusCode == 202) {
          Get.put(AuthController()).updateLoader(false);

          flutterToast(msg: response.data.toString());
        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: e.response?.data.toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      flutterToast(msg: e.response?.data.toString());
      log(e.toString());
    }
  }



  socialLogins({ context, id, email,name,type,token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email.toString(),
        'name': name.toString(),
        'provider_id': id.toString(),
        'provider': type.toString(),
        'device_token': token.toString(),
      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.socialAuth,
        data: data,
      );
      if (response.statusCode == 200) {

        HelperFunctions.saveInPreference(
            "id", response.data['data']['id'].toString());
        HelperFunctions.saveInPreference(
            "userToken", response.data['token'].toString());
        HelperFunctions.saveInPreference(
            "userType",
            response.data['data']['type'].toString());
        HelperFunctions.saveInPreference(
            "image",
            response.data['data']['image']==null?"":
            response.data['data']['image'].toString());

        HelperFunctions.saveInPreference(
            "name", response.data['data']['first_name'].toString());
        HelperFunctions.saveInPreference(
            "last", response.data['data']['last_name'].toString());
        HelperFunctions.saveInPreference(
            "email", response.data['data']['email'].toString());
        HelperFunctions.saveInPreference(
            "phone",response.data['data']['phone']==null?"": response.data['data']['phone'].toString());
        HelperFunctions.saveInPreference(
            "address",response.data['data']['address']==null?"": response.data['data']['address'].toString());
        HelperFunctions.saveInPreference(
            "code",
            response.data['data']['post_code']==null?"":
            response.data['data']['post_code'].toString());
        if(response.data['data']['type']=="client"){
          Get.offAll(() => UserHome(), transition: Transition.cupertinoDialog);
        }
        else{
          Get.offAll(() => StylishHome(), transition: Transition.cupertinoDialog);
        }

        Get.put(AuthController()).updateLoginLoader(false);

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());




      }
      if (response.statusCode == 202) {
        print("response.statusCode");
        print(response.data);

        if(response.data["message"]=="Please verify your email address first"){

          verifyCodeAgain(token:response.data["token"],email:response.data["data"]["email"],id: response.data["data"]["id"].toString(),
              type: response.data["data"]["type"]
          );

        }
        else if(response.data["message"]=="Please add your information first."){
          flutterToast(msg:"Please add your information first" );
          Get.put(AuthController()).updateLoginLoader(false);
          Get.to(CompleteProfile(token:response.data["token"] ,));

        }
        else{
          print(response.data);
          Get.put(AuthController()).updateLoginLoader(false);
          flutterToast(msg: response.data["message"].toString());
        }


      }
    } on dio.DioError catch (e) {
      print(e.response?.data);
      Get.put(AuthController()).updateLoginLoader(false);

      print(e.response?.statusCode);
      flutterToast(msg: e.response?.data["message"]);
      log("e.response");
      log(e.response.toString());

    }
  }



  static Future<GetProfileModel?> getProfileAll() async {
    var response = await client.get(
        uriPath(nameUrl: AppConstants.getProfile),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value.toString()}"}
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return GetProfileModel.fromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }



  static Future<GetProfileModel?> getProfilesTYLISH() async {
    var response = await client.get(
        uriPath(nameUrl: AppConstants.getProfile),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value.toString()}"}
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return GetProfileModel.fromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }


  addBooking({ context, start,end,total}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'address': Get.put(AuthController()).addressController.text,
        'lat': Get.put(AuthController()).lat.value,
        'long': Get.put(AuthController()).lng.value,
        'date': Get.put(UserController()).selectedValue.value.toString()
            .split(' ')[0],
        'start': start.toString(),
        'end': end.toString(),
        'total': total.toString(),
        'description': Get.put(UserController()).desc.text,
        'services':Get.put(AuthController()).selectIndex,
        'after_total':total.toString()
      });
      if (Get.put(AuthController()).selectIndex.isNotEmpty) {
        for (int i = 0; i <Get.put(AuthController()).selectIndex.length; i++) {
          data.fields
              .add(MapEntry('services[$i]', Get.put(AuthController()).selectIndex[i].toString()));
        }
      }
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.addBook,
        data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value.toString()}"


          }
          )
      );
      if (response.statusCode == 200) {
        // Get.offAll(() => UserHome(), transition: Transition.cupertinoDialog);

        Get.put(UserController()).updateAddBookLoader(true);
        Get.put(BookingController()).updateBookId(response.data["data"]["id"].toString());
        flutterToast(msg:"Please pay now");

        Get.put(BookingController()).makePayment(amount:total.toString(),currency:"usd");


        debugPrint(response.data.toString());
        debugPrint(response.data.toString());




      }
      else if (response.statusCode == 202) {
        Get.put(UserController()).updateAddBookLoader(false);


        if(response.data["message"]=="sorry, we don't currently have a stylist in your area availabile, although we are growing fast and will be able to meet your needs soon"){
          flutterToastLong(msg: response.data["message"].toString());
        }
        else{
          flutterToastLong(msg: response.data.toString());
        }
        print(response.data);

        }




    } on dio.DioError catch (e) {
      print(e.response?.data);
      Get.put(UserController()).updateAddBookLoader(false);

      print(e.response?.statusCode);
      flutterToastLong(msg: e.response?.data.toString());
      log("e.response");
      log(e.response.toString());

    }
  }


  confirmBooking() async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'booking_id': Get.put(BookingController()).bookId.value,
        'transaction_id': Get.put(BookingController()).PaymentId.value,

      });

      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.payment,
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value.toString()}"


          }
          )
      );
      if (response.statusCode == 200) {
         Get.offAll(() => UserHome(currentIndex: 1,), transition: Transition.cupertinoDialog);
         flutterToastSuccess(msg: "Appointment Booked Successfully");
         Get.put(UserController()).getOrderData();

        Get.put(UserController()).updateAddBookLoader(false);
        debugPrint(response.data.toString());
        debugPrint(response.data.toString());




      }
      else if (response.statusCode == 202) {
        Get.put(UserController()).updateAddBookLoader(false);


        flutterToastLong(msg: response.data.toString());
        print(response.data);

      }




    } on dio.DioError catch (e) {
      print(e.response?.data);
      Get.put(UserController()).updateAddBookLoader(false);

      print(e.response?.statusCode);
      flutterToastLong(msg: e.response?.data.toString());
      log("e.response");
      log(e.response.toString());

    }
  }



  static Future<GetOrderModel?> getOrderModel() async {
    var response = await client.get(
        uriPath(nameUrl: AppConstants.addBook),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value.toString()}"}
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return GetOrderModel.fromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }




  static Future<AllOrdersModels?> getStylishOrderModel() async {
    var response = await client.get(
        uriPath(nameUrl: AppConstants.stylishBooking),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value.toString()}"}
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return AllOrdersModels.fromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }





  static Future<GetOrderModels?> NewJobModel() async {
    var response = await client.get(
        uriPath(nameUrl: AppConstants.newJob),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value.toString()}"}
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return GetOrderModels.fromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }




  static Future<GetTimeModel?> getTimeList() async {
    var response = await client.get(
        uriPath(nameUrl: AppConstants.timeModelData),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value.toString()}"}
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return GetTimeModel.fromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  cancelBooking({id}) async {
    try {
      var response = await dio.Dio().delete(
          "${AppConstants.baseURL}${AppConstants.cancel}${id.toString()}",
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value}"

          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        flutterToast(msg: "Booking Cancel Successfully");
        Get.put(UserController()).updateSelectTextValue("cancel");
        Get.back();

        Get.put(UserController()).getOrderData();
        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
      else if (response.statusCode == 202) {
        Get.back();


        flutterToastLong(msg: response.data.toString());
        print(response.data);

      }
    } on dio.DioError catch (e) {
      Get.back();

      flutterToast(msg: e.response?.data.toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  rejectBooking({id}) async {
    try {
      var response = await dio.Dio().get(
          "${AppConstants.baseURL}${AppConstants.reject}?booking_request_id=${id.toString()}",
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value}"

          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        flutterToast(msg: "Booking Rejected");
        Get.put(StylishController()).updateSelectTextValue("Pending");
        Get.back();

        Get.put(StylishController()).getOrderData();
        Get.put(StylishController()).getNewOrderData();
        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
      else if (response.statusCode == 202) {
        Get.back();


        flutterToastLong(msg: response.data.toString());
        print(response.data);

      }
    } on dio.DioError catch (e) {
      Get.back();

      flutterToast(msg: e.response?.data.toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  acceptBooking({id}) async {
    try {
      var response = await dio.Dio().get(
          "${AppConstants.baseURL}${AppConstants.accept}?booking_request_id=${id.toString()}",
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value}"

          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        flutterToast(msg: "Booking Accepted");

        Get.put(StylishController()).updateSelectTextValue("act");
        Get.back();
        Get.back();

        Get.put(StylishController()).getOrderData();
        Get.put(StylishController()).getNewOrderData();
        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
      else if (response.statusCode == 202) {
        Get.back();


        flutterToastLong(msg: response.data.toString());
        print(response.data);

      }
    } on dio.DioError catch (e) {
      Get.back();

      flutterToast(msg: e.response?.data.toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  completeBooking({id}) async {
    try {
      var response = await dio.Dio().get(
          "${AppConstants.baseURL}${AppConstants.complete}?booking_id=${id.toString()}",
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value}"

          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        flutterToast(msg: "Booking Completed Successfully!");
        Get.put(StylishController()).updateSelectTextValue("comp");
        Get.back();
        Get.back();

        Get.put(StylishController()).getOrderData();
        Get.put(StylishController()).getNewOrderData();
        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
      else if (response.statusCode == 202) {
        Get.back();


        flutterToastLong(msg: response.data.toString());
        print(response.data);

      }
    } on dio.DioError catch (e) {
      Get.back();

      flutterToast(msg: e.response?.data.toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }
  cancelStylishBooking({id}) async {
    try {
      var response = await dio.Dio().get(
          "${AppConstants.baseURL}${AppConstants.cancelStlish}?booking_id=${id.toString()}",
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value}"

          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        flutterToast(msg: "Booking Cancel Successfully");
        Get.put(StylishController()).updateSelectTextValue("cancel");
        Get.back();

        Get.put(StylishController()).getOrderData();
        Get.put(StylishController()).getNewOrderData();
        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
      else if (response.statusCode == 202) {
        Get.back();


        flutterToastLong(msg: response.data.toString());
        print(response.data);

      }
    } on dio.DioError catch (e) {
      Get.back();

      flutterToast(msg: e.response?.data.toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }




  static Future<UpdateAvailbilitiesModel?> updateTime(
      {context, start,end,id}) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body['start'] = start.toString();
    body['end'] = end.toString();


    print(jsonEncode(body));

    var response = await client.put(uriPath(nameUrl: "${AppConstants.updateAllTime}${id.toString()}"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value}"
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      Get.put(StylishController()).updateTimeLOader(false);
      Get.put(StylishController()).updateTimeLOader1(false);
      Get.put(StylishController()).updateTimeLOader2(false);
      Get.put(StylishController()).updateTimeLOader3(false);
      Get.put(StylishController()).updateTimeLOader4(false);
      Get.put(StylishController()).updateTimeLOader5(false);
      Get.put(StylishController()).getTimeData();
      flutterToastSuccess(msg:"Time Updated");

      print(response.statusCode);
      print(response.body);

      print(jsonString.toString());
      return UpdateAvailbilitiesModel.fromJson(jsonString);
    } else if(response.statusCode == 202) {

      var jsonString = jsonDecode(response.body);
      Get.put(StylishController()).updateTimeLOader(false);
      Get.put(StylishController()).updateTimeLOader1(false);
      Get.put(StylishController()).updateTimeLOader2(false);
      Get.put(StylishController()).updateTimeLOader3(false);
      Get.put(StylishController()).updateTimeLOader4(false);
      Get.put(StylishController()).updateTimeLOader5(false);
      flutterToast(msg: jsonString.toString());

      //show error message
      return null;
    }
  }



  static Future<PaymentModel?> userPaymentModel() async {
    var response = await client.get(
        uriPath(nameUrl: AppConstants.payUser),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value.toString()}"}
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return PaymentModel.fromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }



  static Future<StylishPaymentModel?> stylishPaymentModel() async {
    var response = await client.get(
        uriPath(nameUrl: AppConstants.styPayment),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value.toString()}"}
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      debugPrint(response.body);
      debugPrint(jsonString["message"].toString());
      Get.put(StylishController()).updateAccount(jsonString["account"]==false?false:true);
      Get.put(StylishController()).updatePaymentText(jsonString["message"].toString());
      
      return StylishPaymentModel.fromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  ratingData({var id,rating, required BuildContext context,comment}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'booking_id': id.toString(),
        'rating': rating,
        'comment': comment.toString(),
      });
      print(data.fields);

      var response =
      await dio.Dio().post(AppConstants.baseURL + AppConstants.review,
          data: data,
          options: dio.Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value}"
          }));

      debugPrint(response.toString());
      print(data.fields);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.put(UserController()).getOrderData();

        Get.put(UserController()).updateIsRating(false);
        Get.back();


        flutterToastSuccess(msg: "Thanks for your rating!");

        debugPrint(response.statusMessage);
      }
      else if (response.statusCode == 202) {


        Get.put(UserController()).updateIsRating(false);
        flutterToast(msg: response.data.toString());
        print(response.data);

      }

    } on dio.DioError catch (e) {
      flutterToast(msg: e.response?.data.toString());
      Get.put(UserController()).updateIsRating(false);

      debugPrint(e.response.toString());
    }
  }


  logoutUser() async {
    try {
      var response =
      await dio.Dio().get(AppConstants.baseURL + AppConstants.logoutUserAll,

          options: dio.Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(UserController()).token.value}"
          }));

      debugPrint(response.toString());

      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

      }
      else if (response.statusCode == 202) {




      }

    } on dio.DioError catch (e) {

    }
  }

  logoutStylish() async {
    try {
      var response =
      await dio.Dio().get(AppConstants.baseURL + AppConstants.logoutUserAll,

          options: dio.Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(StylishController()).token.value}"
          }));

      debugPrint(response.toString());

      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
      }
      else if (response.statusCode == 202) {

        debugPrint(response.data.toString());


      }

    } on dio.DioError catch (e) {

    }
  }
}
