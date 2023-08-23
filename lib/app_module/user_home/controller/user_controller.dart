import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/model/services_model.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/model/orrder_model.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/profile/model/payment_model.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/user_dashboard/model/category_model.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/widgets/helper_function.dart';

class UserController extends GetxController {
  var updateProfileLoader = false.obs;
  var addBookLoader = false.obs;
  var cancelBookLoader = false.obs;
  var isRating=false.obs;
  updateIsRating(val){
    isRating.value=val;
    update();
  }

  var selectValueText = "Pending".obs;
  updateSelectTextValue(val){
    selectValueText.value=val;
    update();
  }

  updateAddBookLoader(val){
    addBookLoader.value = val;
    update();


  }

  updateCancelLoader(val){
    cancelBookLoader.value = val;
    update();


  }
  Rx<DateTime> selectedValue = DateTime.now().obs;

  updateDate(val) {
    selectedValue.value = val;
    update();
  }

  clearState() {
    updateFirstName("");
    updateAddress("");
    updatePhone("");
    updateLast("");
    updatePostal("");
    updateToken("");
    updateEmail("");
    updateImage("");
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
    getCatData();
    getServiceData();

    HelperFunctions.getFromPreference("id").then((value) {
      id.value = value;
      print(id.value.toString());

      update();
    });
    HelperFunctions.getFromPreference("userToken").then((value) {
      token.value = value;
      print(token.value.toString());
      getProfileData();
      getOrderData();
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
      print(name.value.toString());

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

  var data = "all".obs;
  updateDataHome(val) {
    data.value = val;
    update();
  }

  var categoryIndex = 0.obs;
  updateCategoryIndex(val) {
    categoryIndex.value = val;
    update();
  }

  var isCatLoading = false.obs;
  var isServiceLoading = false.obs;
  var catList = <CategoryModel>[].obs;

  getCatData({search}) async {
    try {
      isCatLoading(true);
      update();

      var profData = await ApiManger.allCat();
      if (profData != null) {
        catList.value = profData.data as dynamic;
        print("This is service ${profData.data}");
      } else {
        isCatLoading(false);
        update();
      }
    } catch (e) {
      isCatLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isCatLoading(false);
      update();
    }
    update();
  }

  var name = "all".obs;
  updateName(val) {
    name.value = val;
    update();
  }

  var serviceList = <ServicesData>[].obs;

  getServiceData({search = "", String? cat}) async {
    try {
      isServiceLoading(true);
      update();

      var profData = await ApiManger.getServiceAll(search: search, cat: cat);
      if (profData != null) {
        serviceList.value = profData.data as dynamic;
        print("This is service ${profData.data}");
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

  var desc = TextEditingController();

  var getProfile;
  var isProfileLoading = false.obs;
  getProfileData() async {
    try {
      isProfileLoading(true);
      update();

      var profData = await ApiManger.getProfileAll();
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


  var getBookList = <OrderModelData>[].obs;
  var isOrderLoading = false.obs;
  getOrderData() async {
    try {
      isOrderLoading(true);
      update();

      var profData = await ApiManger.getOrderModel();
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






  var paymentList = <UserPaymentDate>[].obs;
  var isPaymentLoading = false.obs;
  getPaymentData() async {
    try {
      isPaymentLoading(true);
      update();

      var profData = await ApiManger.userPaymentModel();
      if (profData != null) {
        paymentList.value = profData.date as dynamic;
        print("This is oRDER ${profData.date}");
      } else {
        isPaymentLoading(false);
        update();
      }
    } catch (e) {
      isPaymentLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isPaymentLoading(false);
      update();
    }
    update();
  }
}
