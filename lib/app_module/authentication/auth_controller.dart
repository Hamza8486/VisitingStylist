
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/model/services_model.dart';
import 'package:stylish_app/services/api_manager.dart';

class AuthController extends GetxController {
  var isVisible = true.obs;
  var isVisible1 = true.obs;
  void resetSelectedServices() {
    selectedServices.clear();
    update();
  }
  var isVisible2 = true.obs;
  var userType="".obs;
  var loaderForget = false.obs;
  var completeProfile = false.obs;
  var isServiceLoading = false.obs;
  var loaderPassword = false.obs;
  var selectedServiceId = "".obs;
  updateSelectId(val) {
    selectedServiceId.value = val;
    update();
  }
  updatePasswordLoader(val){
    loaderPassword.value = val;
    update();}
  updateComplete(val){
    completeProfile.value = val;
    update();}


  updateForgetLoader(val){
    loaderForget.value = val;
    update();}
  updateVisibleStatus() {
    isVisible.toggle();
    update();
  }
  updateLoader(val){
    loader.value = val;
    update();


  }
  updateOtp(val){
    otp.value = val;
    update();


  }
  updateResendOtp(val){
    resend.value = val;
    update();


  }
  updateResendVerify(val){
    resendVerify.value = val;
    update();


  }
  updateLoginLoader(val){
    loaderLogin.value = val;
    update();


  }
  updateSocialLoader(val){
    loaderSocialLogin.value = val;
    update();


  }
  var loader = false.obs;
  var otp = false.obs;
  var resend = false.obs;
  var resendVerify = false.obs;
  var loaderLogin = false.obs;
  var loaderSocialLogin = false.obs;
  updateUserType(val){
    userType.value = val;
    update();
  }

  updateVisible1Status() {
    isVisible1.toggle();
    update();
  }
  updateVisible2Status() {
    isVisible2.toggle();
    update();
  }

  var lat="".obs;
  var lng="".obs;
  updateLat(val){
    lat.value=val;
    update();

  }
  updateLng(val){
    lng.value=val;
    update();

  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  TextEditingController emailRegController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passRegController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController hearController = TextEditingController();
  TextEditingController travelController = TextEditingController();



  TextEditingController emailForgetController = TextEditingController();
  TextEditingController passForgetController = TextEditingController();
  TextEditingController passConfirmForgetController = TextEditingController();

  //
  // RxBool isCheck = false.obs;
  // updateCheck(val) {
  //   isCheck.value = val;
  //   update();
  // }

  RxBool isCheck2 = false.obs;
  updateCheck2(val) {
    isCheck2.value = val;
    update();
  }


  clearAllController(){
    emailRegController.clear();
    fullNameController.clear();
    lastNameController.clear();
    passRegController.clear();
    postalController.clear();
    phoneController.clear();
    addressController.clear();
    updateLng("");
    updateLat("");
  }

  clear(){
    emailRegController.clear();
    fullNameController.clear();
    lastNameController.clear();
    passRegController.clear();
    postalController.clear();
    phoneController.clear();
    addressController.clear();
    updateLng("");
    updateLat("");
  }


  @override
  Future<void> onInit() async {
    super.onInit();
    getServiceData();
  }

  var serviceList = <ServicesData>[].obs;

  getServiceData({search="",String?cat}) async {
    try {
      isServiceLoading(true);
      update();

      var profData = await ApiManger.getServiceAll(search: search,cat: cat);
      if (profData != null) {
        serviceList.value = profData.data as dynamic;
        print(
            "This is service ${profData.data}");
      } else {
        isServiceLoading(false);
        update();
      }
    } catch (e) {
      isServiceLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isServiceLoading(false);
      update();
    }
    update();
  }

  File?fileCnic;
  File?fileBack;
  File?fileCv;
  File?fileInsurance;
  File?fileDb;

  int totalAmount =0;


  var selectIndex = [].obs;
  var selectName = [].obs;
  updateName(var val) {
    if (selectName.contains(val)) {
      selectName.remove(val);
    } else {
      selectName.add(val);
    }
    update();
  }
  updateValue(var val) {
    if (selectIndex.contains(val)) {
      selectIndex.remove(val);
    } else {
      selectIndex.add(val);
    }
    update();
  }
clearLogin(){
    emailController.clear();
    passController.clear();
    emailForgetController.clear();
    emailForgetController.clear();
    passForgetController.clear();
    passConfirmForgetController.clear();
}

clearCompleteProfile(){
  selectIndex.clear();
 selectName.clear();
  fileDb=null;
  fileCv=null;
  fileInsurance=null;
  fileBack=null;
  fileCnic=null;
}

  List<ServicesData> selectedServices = []; // List of selected services

  // Method to calculate total amount based on selected services
  int calculateTotalAmount() {
    int total = 0;
    for (var service in selectedServices) {
      total += service.price ?? 0;
    }
    return total;
  }

  // Method to update selected services and notify listeners
  void toggleServiceSelection(ServicesData service) {
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
    } else {
      selectedServices.add(service);
    }
    update();
  }


  var startTimeController = TextEditingController();
  var startTimeController1 = TextEditingController();
  var startTimeController2 = TextEditingController();
  var startTimeController3 = TextEditingController();
  var startTimeController4 = TextEditingController();
  var startTimeController5 = TextEditingController();
  var endTimeController = TextEditingController();
  var endTimeController1 = TextEditingController();
  var endTimeController2 = TextEditingController();
  var endTimeController3 = TextEditingController();
  var endTimeController4 = TextEditingController();
  var endTimeController5 = TextEditingController();




  RxBool isAllCheck = false.obs;
  updateAllCheck(val) {
    isAllCheck.value = val;
    update();
  }

}
