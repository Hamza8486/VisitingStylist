import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_booking/model/order.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_booking/model/orrder_model.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_profile/model/stylish_payment.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_profile/model/time_model.dart';
import 'package:stylish_app/services/api_manager.dart';

import 'package:stylish_app/widgets/helper_function.dart';

class StylishController extends GetxController {

  clearState() {
    updateFirstName("");
    updateAddress("");
    updatePhone("");
    updateLast("");
    updatePostal("");
    updateToken("");
    updateEmail("");
    updateImage("");
    updateSelectTextValue("Pending");
  }
  var selectValueText = "Pending".obs;
  updateSelectTextValue(val){
    selectValueText.value=val;
    update();
  }
  var id = "".obs;
  var token = "".obs;
  var nameFirst = "".obs;
  var image = "".obs;
  File? file;
  var last = "".obs;
  var phone = "".obs;
  var email = "".obs;
  var address = "".obs;
  var postal = "".obs;
  var userType = "".obs;
  updateFirstName(val) {
    nameFirst.value = val;
    update();
  }

  updateToken(val) {
    token.value = val;
    update();
  }

  updateAddress(val) {
    address.value = val;
    update();
  }

  updateImage(val) {
    image.value = val;
    update();
  }

  updatePhone(val) {
    phone.value = val;
    update();
  }

  updateLast(val) {
    last.value = val;
    update();
  }

  updatePostal(val) {
    postal.value = val;
    update();
  }

  updateEmail(val) {
    email.value = val;
    update();
  }

  @override
  Future<void> onInit() async {


    HelperFunctions.getFromPreference("id").then((value) {
      id.value = value;
      print(id.value.toString());

      update();
    });
    HelperFunctions.getFromPreference("userToken").then((value) {
      token.value = value;
      print(token.value.toString());
      getProfileData();
      getNewOrderData();
      getOrderData();
      getTimeData();
      getPaymentData();



      update();
    });

    HelperFunctions.getFromPreference("type").then((value) {
      userType.value = value;
      print(userType.value.toString());

      update();
    });
    HelperFunctions.getFromPreference("name").then((value) {
      nameFirst.value = value;
      print(nameFirst.value.toString());

      update();
    });
    HelperFunctions.getFromPreference("last").then((value) {
      last.value = value;
      print(last.value.toString());

      update();
    });
    HelperFunctions.getFromPreference("email").then((value) {
      email.value = value;

      update();
    });
    HelperFunctions.getFromPreference("phone").then((value) {
      phone.value = value;

      update();
    });
    HelperFunctions.getFromPreference("address").then((value) {
      address.value = value;

      update();
    });
    HelperFunctions.getFromPreference("code").then((value) {
      postal.value = value;

      update();
    });

    super.onInit();
    //getHistoryData(id: "30746b29-8044-4c6b-aef8-f5cfdb584200");
  }

  var getProfile;
  var isProfileLoading = false.obs;
  getProfileData() async {
    try {
      isProfileLoading(true);
      update();

      var profData = await ApiManger.getProfilesTYLISH();
      if (profData != null) {
        getProfile = profData.data;
        updateImage(profData.data?.image==null?"":profData.data?.image);
        print("This is profile ${profData.data}");
      } else {
        isProfileLoading(false);
        update();
      }
    } catch (e) {
      isProfileLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isProfileLoading(false);
      update();
    }
    update();
  }



  var getBookList = <AllData>[].obs;
  var isOrderLoading = false.obs;
  getOrderData() async {
    try {
      isOrderLoading(true);
      update();

      var profData = await ApiManger.getStylishOrderModel();
      if (profData != null) {
        getBookList.value = profData.data as dynamic;
        print("This is oRDER ${profData.data}");
      } else {
        isOrderLoading(false);
        update();
      }
    } catch (e) {
      isOrderLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isOrderLoading(false);
      update();
    }
    update();
  }



  var getNewJobList = <OrderStylishData>[].obs;
  var isOrderNewJobLoading = false.obs;
  getNewOrderData() async {
    try {
      isOrderNewJobLoading(true);
      update();

      var profData = await ApiManger.NewJobModel();
      if (profData != null) {
        getNewJobList.value = profData.data as dynamic;
        print("This is oRDER ${profData.data}");
      } else {
        isOrderNewJobLoading(false);
        update();
      }
    } catch (e) {
      isOrderNewJobLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isOrderNewJobLoading(false);
      update();
    }
    update();
  }





  var newTimeList = <TimeModelData>[].obs;
  var timeLoading = false.obs;
  getTimeData() async {
    try {
      timeLoading(true);
      update();

      var profData = await ApiManger.getTimeList();
      if (profData != null) {
        newTimeList.value = profData.data as dynamic;
        print("This is time list ${profData.data}");
      } else {
        timeLoading(false);
        update();
      }
    } catch (e) {
      timeLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      timeLoading(false);
      update();
    }
    update();
  }

  var updateLoader=false.obs;
  var updateLoader1=false.obs;
  var updateLoader2=false.obs;
  var updateLoader3=false.obs;
  var updateLoader4=false.obs;
  var updateLoader5=false.obs;
   updateTimeLOader(val){
     updateLoader.value=val;
     update();
   }

  updateTimeLOader1(val){
    updateLoader1.value=val;
    update();
  }
  updateTimeLOader2(val){
    updateLoader2.value=val;
    update();
  }
  updateTimeLOader3(val){
    updateLoader3.value=val;
    update();
  }
  updateTimeLOader4(val){
    updateLoader4.value=val;
    update();
  }
  updateTimeLOader5(val){
    updateLoader5.value=val;
    update();
  }




  var paymentList = <StylishPaymentAllData>[].obs;
  var isPaymentLoading = false.obs;
  getPaymentData() async {
    try {
      isPaymentLoading(true);
      update();

      var profData = await ApiManger.stylishPaymentModel();
      if (profData != null) {
        paymentList.value = profData.data as dynamic;
        print("This is oRDER ${profData.message}");
      } else {
        isPaymentLoading(false);
        update();
      }
    } catch (e) {
      isPaymentLoading(false);
      update();
      print("Hamza");
    } finally {

      isPaymentLoading(false);
      update();
    }
    update();
  }



  var latStart="".obs;
  var latEnd="".obs;
  var lngStart="".obs;
  var lngEnd="".obs;
  updateLat(val){
    latStart.value=val;
    update();

  }
  updateEndLat(val){
    latEnd.value=val;
    update();

  }
  updateLng(val){
    lngStart.value=val;
    update();

  }
  updateEndLng(val){
    lngEnd.value=val;
    update();

  }

  var account=false.obs;
  updateAccount(val){
    account.value=val;
    update();
  }

  var paymentText="".obs;
  updatePaymentText(val){
    paymentText.value=val;
    update();

  }
}
