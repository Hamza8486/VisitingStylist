import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stylish_app/app_module/authentication/address.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/component.dart';
import 'package:stylish_app/app_module/authentication/forget/component/get_service.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/controller/booking_controller.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/drop_down.dart';

import '../../../../../widgets/app_button.dart';

class AddAppointment extends StatefulWidget {
  const AddAppointment({Key? key}) : super(key: key);

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  DateTime currentDateTime = DateTime.now();
  final userController = Get.put(UserController());
  final authController = Get.put(AuthController());

  List time2ndList = [
    {"label": '7:00 AM - 9:00 AM', "value": '07:00:00 - 09:00:00'},
    {"label": '9:00 AM - 11:00 AM', "value": '09:00:00 - 11:00:00'},
    {"label": '11:00 AM - 1:00 PM', "value": '11:00:00 - 13:00:00'},
    {"label": '1:00 PM - 3:00 PM', "value": '13:00:00 - 15:00:00'},
    {"label": '3:00 PM - 5:00 PM', "value": '15:00:00 - 17:00:00'},
    {"label": '5:00 PM - 7:00 PM', "value": '17:00:00 - 19:00:00'},
    {"label": '7:00 PM - 9:00 PM', "value": '19:00:00 - 21:00:00'},
    {"label": '9:00 PM - 11:00 PM', "value": '21:00:00 - 23:00:00'},
  ];
  String? time;
  String? time1;
  String convertTo24HourFormat(String time) {
    DateTime parsedTime = DateFormat.jm().parse(time);
    return DateFormat("HH:mm:ss").format(parsedTime);
  }
  @override
  Widget build(BuildContext context) {
    List<String> timeTwoValue = [];
    for (int i = 0; i < time2ndList.length; i++) {
      timeTwoValue.add(time2ndList[i]["label"]);
    }
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body:Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04, vertical: Get.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  children: [
                    backButton(onTap: () {
                      Navigator.pop(context);
                    }),
                    SizedBox(
                      width: Get.width * 0.23,
                    ),
                    AppText(
                      title: "Add Booking",
                      color: AppColor.blackColor,
                      size: AppSizes.size_18,
                      fontFamily: AppFont.semi,
                    ),
                    Container()
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        textAuth(
                            text:
                                "Select Date - ${DateFormat.yMMM().format(DateTime.now())}",
                            color: Colors.transparent),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        DatePicker(
                          DateTime.now(),
                          height: Get.height * 0.15,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: AppColor.primaryColor,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            userController.updateDate(date);
                            print(userController.selectedValue.value);
                            print(userController.selectedValue.value);
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(
                            text: "Select Multiple Services", color: Colors.red),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Obx(() {
                          return stylishField(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    context: context,
                                    builder: (context) => AddService());
                              },
                              hint: authController.selectName.isEmpty
                                  ? "Select Services"
                                  : authController.selectName.join(", "),
                              isPrefix: true,
                              hintColor: authController.selectName.isEmpty
                                  ? AppColor.greyColors
                                  : AppColor.boldBlackColor,
                              isRead: true,
                              cur: false,
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black.withOpacity(0.5),
                                size: AppSizes.size_20,
                              ),
                              isSuffix: false);
                        }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: "Select Time Slot", color: Colors.red),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        dropDownButtons(
                            contentPadding: EdgeInsets.only(
                                top: Get.height * 0.016,
                                bottom: Get.height * 0.016,
                                right: 10),
                            hinText: "Select Time Slot",
                            value: time,
                            items: timeTwoValue.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (val) {


                              setState(() {

                                for (int i = 0;
                                i < time2ndList.length;
                                i++) {
                                  if (val.toString() ==
                                      time2ndList[i]["label"]) {
                                    time1=time2ndList[i]["value"];


                                  }
                                }
                                time=val;
                              });
                            }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: "Select Address", color: Colors.red),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Obx(() {
                          return stylishField(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Get.to(AddAddress());
                              },
                              hint: authController.userType.value == "client"
                                  ? "Select Address"
                                  : "Select Address",
                              isRead: true,
                              cur: false,
                              textInputType: TextInputType.streetAddress,
                              controller: authController.addressController,
                              child1: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(
                                  "assets/icons/loc.png",
                                  height: Get.height * 0.01,
                                ),
                              ),
                              isSuffix: true);
                        }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: "Any Additional Information", color: Colors.transparent),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        stylishField(
                            hint: "Any Additional Information",
                            isPrefix: true,
                            max: 3,
                            controller: userController.desc,
                            isSuffix: true,
                            textInputAction: TextInputAction.done),
                      ],
                    ),
                  ),
                ),
                isKeyBoard
                    ? SizedBox.shrink()
                    :
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      title: "Total Amount",
                      size: AppSizes.size_14,
                      fontFamily: AppFont.medium,
                      color: AppColor.greyColor,
                    ),
                    Obx(
                      () {
                        return AppText(
                          title: "\$${authController.calculateTotalAmount()}",
                          size: AppSizes.size_16,
                          fontFamily:
                          authController.selectName.isEmpty
                              ?AppFont.medium
                              :

                          AppFont.medium,
                          color: AppColor.boldBlackColor,
                        );
                      }
                    )
                  ],
                ),
                isKeyBoard
                    ? SizedBox.shrink()
                    : SizedBox(height: Get.height * .015),
                isKeyBoard
                    ? SizedBox.shrink()
                    : Obx(
                      () {
                        return AppButton(
                            buttonWidth: Get.width,
                            buttonRadius: BorderRadius.circular(10),
                            buttonName: "Pay Now",
                            buttonColor: AppColor.primaryColor,
                            textColor:
                            authController.selectName.isEmpty
                                ?AppColor.whiteColor
                                :
                            AppColor.whiteColor,
                            onTap: () {
                              print(time1);
                              if (validateBooking(context)) {
                                userController.updateAddBookLoader(true);
                                ApiManger().addBooking(context: context,
                                start:time1.toString().split(" - ").first,
                                  end: time1.toString().split(" - ").last,
                                  total: authController.calculateTotalAmount()
                                );

                              }

                            });
                      }
                    )
              ],
            ),
          ),
        ),
        Obx(() {
          return userController.addBookLoader.value == false
              ? SizedBox.shrink()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black26,
                  child: Center(
                      child:
                          SpinKitThreeBounce(size: 25, color: AppColor.black)),
                );
        })
      ],
    );
  }

  bool validateBooking(BuildContext context) {
    if (authController.selectName.isEmpty) {
      flutterToast(msg: "Please select services");
      return false;
    }
    if (time == null) {
      flutterToast(msg: "Please select time slot");
      return false;
    }
    if (authController.addressController.text.isEmpty) {
      flutterToast(msg: "Please select address");
      return false;
    }
    // if (userController.desc.text.isEmpty) {
    //   flutterToast(msg: "Please enter short description");
    //   return false;
    // }

    return true;
  }
}
