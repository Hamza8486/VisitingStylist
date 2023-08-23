
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/component.dart';
import 'package:stylish_app/app_module/stylish_home/controller/stylish_controller.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';




class StylishAvailbility extends StatefulWidget {
  const StylishAvailbility({Key? key}) : super(key: key);

  @override
  State<StylishAvailbility> createState() => _StylishAvailbilityState();
}

class _StylishAvailbilityState extends State<StylishAvailbility> {



  final authController = Get.put(AuthController());
  final stylishController = Get.put(StylishController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.startTimeController.text=stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[0].start==null?"": stylishController.newTimeList[0].start.toString();
    authController.startTimeController1.text=stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[1].start==null?"": stylishController.newTimeList[1].start.toString();
    authController.startTimeController2.text=stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[2].start==null?"": stylishController.newTimeList[2].start.toString();
    authController.startTimeController3.text= stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[3].start==null?"":stylishController.newTimeList[3].start.toString();
    authController.startTimeController4.text=stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[4].start==null?"": stylishController.newTimeList[4].start.toString();
    authController.startTimeController5.text=stylishController.newTimeList.isEmpty?"": stylishController.newTimeList[5].start==null?"":stylishController.newTimeList[5].start.toString();

    authController.endTimeController.text=stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[0].end==null?"": stylishController.newTimeList[0].end.toString();
    authController.endTimeController1.text=stylishController.newTimeList.isEmpty?"": stylishController.newTimeList[1].end==null?"":stylishController.newTimeList[1].end.toString();
    authController.endTimeController2.text=stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[2].end==null?"": stylishController.newTimeList[2].end.toString();
    authController.endTimeController3.text=stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[3].end==null?"": stylishController.newTimeList[3].end.toString();
    authController.endTimeController4.text= stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[4].end==null?"":stylishController.newTimeList[4].end.toString();
    authController.endTimeController5.text=stylishController.newTimeList.isEmpty?"":stylishController.newTimeList[5].end==null?"": stylishController.newTimeList[5].end.toString();
    setState(() {

    });
  }



  @override
  Widget build(BuildContext context) {
    print(stylishController.newTimeList[0].start.toString());

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
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
                backButton(

                    onTap: () {
                      Get.back();
                    }),
                SizedBox(
                  width: Get.width * 0.16,
                ),
                AppText(
                  title: "Update Availability",
                  color: AppColor.blackColor,
                  size: AppSizes.size_18,
                  fontFamily: AppFont.semi,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(
                  height: Get.height * 0.015,
                ),
                AppText(
                  title: "Monday",
                  color: AppColor.blackColor,
                  size: AppSizes.size_16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFont.medium,
                ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: stylishField(
                            hint: "Start Time",
                            controller: authController.startTimeController,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.startTimeController.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.startTimeController.text}");
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: Get.width*0.04,),
                      Expanded(
                        child: stylishField(
                            hint: "End Time",
                            controller: authController.endTimeController,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.endTimeController.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.startTimeController.text}");
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                        () {
                          return
                          Get.put(StylishController()).updateLoader.value?
                            Center(
                                child: SpinKitThreeBounce(
                                    size: 25, color: AppColor.primaryColor)
                            ):
                            GestureDetector(
                            onTap:(){

                              if(validateTime(context)){
                                Get.put(StylishController()).updateTimeLOader(true);
                                ApiManger.updateTime(context: context,
                                id:stylishController.newTimeList[0].id.toString(),
                                  start: authController.startTimeController.text,
                                  end: authController.endTimeController.text
                                );
                              }
                            },
                            child: Container(
                              decoration:BoxDecoration(color:
                              AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                                child: AppText(
                                  title: "Update Now",
                                  size: AppSizes.size_14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFont.semi,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),

                  AppText(
                    title: "Tuesday",
                    color: AppColor.blackColor,
                    size: AppSizes.size_16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.medium,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: stylishField(
                            hint: "Start Time",
                            controller: authController.startTimeController1,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.startTimeController1.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.startTimeController.text}");
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: Get.width*0.04,),
                      Expanded(
                        child: stylishField(
                            hint: "End Time",
                            controller: authController.endTimeController1,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.endTimeController1.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.endTimeController1.text}");
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                              () {
                            return
                              Get.put(StylishController()).updateLoader1.value?
                              Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor)
                              ):
                              GestureDetector(
                                onTap:(){

                                  if(validateTime(context)){
                                    Get.put(StylishController()).updateTimeLOader1(true);
                                    ApiManger.updateTime(context: context,
                                        id: stylishController.newTimeList[1].id.toString(),
                                        start: authController.startTimeController1.text,
                                        end: authController.endTimeController1.text
                                    );
                                  }
                                },
                                child: Container(
                                  decoration:BoxDecoration(color:
                                  AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                                    child: AppText(
                                      title: "Update Now",
                                      size: AppSizes.size_14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.semi,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              );
                          }
                      ),
                    ],
                  ),
                  AppText(
                    title: "Wednesday",
                    color: AppColor.blackColor,
                    size: AppSizes.size_16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.medium,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: stylishField(
                            hint: "Start Time",
                            controller:authController.startTimeController2,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.startTimeController2.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.startTimeController2.text}");
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: Get.width*0.04,),
                      Expanded(
                        child: stylishField(
                            hint: "End Time",
                            controller:authController.endTimeController2,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.endTimeController2.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.endTimeController2.text}");
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                              () {
                            return
                              Get.put(StylishController()).updateLoader2.value?
                              Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor)
                              ):
                              GestureDetector(
                                onTap:(){

                                  if(validateTime(context)){
                                    Get.put(StylishController()).updateTimeLOader2(true);
                                    ApiManger.updateTime(context: context,
                                        id: stylishController.newTimeList[2].id.toString(),
                                        start: authController.startTimeController2.text,
                                        end: authController.endTimeController2.text
                                    );
                                  }
                                },
                                child: Container(
                                  decoration:BoxDecoration(color:
                                  AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                                    child: AppText(
                                      title: "Update Now",
                                      size: AppSizes.size_14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.semi,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              );
                          }
                      ),
                    ],
                  ),
                  AppText(
                    title: "Thursday",
                    color: AppColor.blackColor,
                    size: AppSizes.size_16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.medium,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: stylishField(
                            hint: "Start Time",
                            controller: authController.startTimeController3,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.startTimeController3.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.startTimeController3.text}");
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: Get.width*0.04,),
                      Expanded(
                        child: stylishField(
                            hint: "End Time",
                            controller: authController.endTimeController3,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.endTimeController3.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.endTimeController3.text}");
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                              () {
                            return
                              Get.put(StylishController()).updateLoader3.value?
                              Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor)
                              ):
                              GestureDetector(
                                onTap:(){

                                  if(validateTime(context)){
                                    Get.put(StylishController()).updateTimeLOader3(true);
                                    ApiManger.updateTime(context: context,
                                        id: stylishController.newTimeList[3].id.toString(),
                                        start: authController.startTimeController3.text,
                                        end: authController.endTimeController3.text
                                    );
                                  }
                                },
                                child: Container(
                                  decoration:BoxDecoration(color:
                                  AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                                    child: AppText(
                                      title: "Update Now",
                                      size: AppSizes.size_14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.semi,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              );
                          }
                      ),
                    ],
                  ),
                  AppText(
                    title: "Friday",
                    color: AppColor.blackColor,
                    size: AppSizes.size_16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.medium,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: stylishField(
                            hint: "Start Time",
                            controller:authController.startTimeController4,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.startTimeController4.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.startTimeController4.text}");
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: Get.width*0.04,),
                      Expanded(
                        child: stylishField(
                            hint: "End Time",
                            controller: authController.endTimeController4,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.endTimeController4.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.endTimeController4.text}");
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                              () {
                            return
                              Get.put(StylishController()).updateLoader4.value?
                              Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor)
                              ):
                              GestureDetector(
                                onTap:(){

                                  if(validateTime(context)){
                                    Get.put(StylishController()).updateTimeLOader4(true);
                                    ApiManger.updateTime(context: context,
                                        id: stylishController.newTimeList[4].id.toString(),
                                        start: authController.startTimeController4.text,
                                        end: authController.endTimeController4.text
                                    );
                                  }
                                },
                                child: Container(
                                  decoration:BoxDecoration(color:
                                  AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                                    child: AppText(
                                      title: "Update Now",
                                      size: AppSizes.size_14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.semi,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              );
                          }
                      ),
                    ],
                  ),
                  AppText(
                    title: "Saturday",
                    color: AppColor.blackColor,
                    size: AppSizes.size_16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.medium,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: stylishField(
                            hint: "Start Time",
                            controller:authController.startTimeController5,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.startTimeController5.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.startTimeController5.text}");
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: Get.width*0.04,),
                      Expanded(
                        child: stylishField(
                            hint: "End Time",
                            controller: authController.endTimeController5,
                            isPrefix: true,

                            isSuffix: true,
                          isRead: true,
                          cur: false,
                          onTap: ()async{

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedTime != null) {
                              final String formattedTime =
                                  '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                  '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                              setState(() {
                                authController.endTimeController5.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                print("this is time  ${authController.endTimeController5.text}");
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                              () {
                            return
                              Get.put(StylishController()).updateLoader5.value?
                              Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor)
                              ):
                              GestureDetector(
                                onTap:(){

                                  if(validateTime(context)){
                                    Get.put(StylishController()).updateTimeLOader5(true);
                                    ApiManger.updateTime(context: context,
                                        id: stylishController.newTimeList[5].id.toString(),
                                        start: authController.startTimeController5.text,
                                        end: authController.endTimeController5.text
                                    );
                                  }
                                },
                                child: Container(
                                  decoration:BoxDecoration(color:
                                  AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                                    child: AppText(
                                      title: "Update Now",
                                      size: AppSizes.size_14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.semi,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              );
                          }
                      ),
                    ],
                  ),
              ],),
            ))

          ],
        ),
      ),
    );
  }
  bool validateTime(BuildContext context) {
    if (Get.put(AuthController()).startTimeController.text.isEmpty) {
      flutterToast(msg: "Please enter start time");
      return false;
    }
    if (Get.put(AuthController()).endTimeController.text.isEmpty) {
      flutterToast(msg: "Please enter end time");
      return false;
    }


    return true;



  }

  bool validateTime1(BuildContext context) {
    if (Get.put(AuthController()).startTimeController1.text.isEmpty) {
      flutterToast(msg: "Please enter start time");
      return false;
    }
    if (Get.put(AuthController()).endTimeController1.text.isEmpty) {
      flutterToast(msg: "Please enter end time");
      return false;
    }


    return true;



  }
  bool validateTime2(BuildContext context) {
    if (Get.put(AuthController()).startTimeController2.text.isEmpty) {
      flutterToast(msg: "Please enter start time");
      return false;
    }
    if (Get.put(AuthController()).endTimeController2.text.isEmpty) {
      flutterToast(msg: "Please enter end time");
      return false;
    }


    return true;



  }
  bool validateTime3(BuildContext context) {
    if (Get.put(AuthController()).startTimeController3.text.isEmpty) {
      flutterToast(msg: "Please enter start time");
      return false;
    }
    if (Get.put(AuthController()).endTimeController3.text.isEmpty) {
      flutterToast(msg: "Please enter end time");
      return false;
    }


    return true;



  }
  bool validateTime4(BuildContext context) {
    if (Get.put(AuthController()).startTimeController4.text.isEmpty) {
      flutterToast(msg: "Please enter start time");
      return false;
    }
    if (Get.put(AuthController()).endTimeController4.text.isEmpty) {
      flutterToast(msg: "Please enter end time");
      return false;
    }


    return true;



  }
  bool validateTime5(BuildContext context) {
    if (Get.put(AuthController()).startTimeController5.text.isEmpty) {
      flutterToast(msg: "Please enter start time");
      return false;
    }
    if (Get.put(AuthController()).endTimeController5.text.isEmpty) {
      flutterToast(msg: "Please enter end time");
      return false;
    }


    return true;



  }
}
