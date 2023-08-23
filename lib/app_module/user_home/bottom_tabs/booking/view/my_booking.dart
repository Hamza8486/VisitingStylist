import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/tabs/active.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/tabs/cancel.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/tabs/complete.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/tabs/pending.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';

class MyBookings extends StatefulWidget {
   MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
   String formatTime(String time24) {
     final parsedTime = DateFormat('HH:mm:ss').parse(time24);
     final formattedTime = DateFormat('h:mm a').format(parsedTime);
     return formattedTime;
   }

  final homeController  = Get.put(UserController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getOrderData();
    homeController.updateSelectTextValue("Pending");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            Center(
              child: AppText(
                title: "My Bookings",
                size: AppSizes.size_20,
                overFlow: TextOverflow.ellipsis,
                maxLines: 1,
                fontFamily: AppFont.semi,
                fontWeight: FontWeight.w600,
                color: AppColor.blackDarkColor,
              ),
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                        () {
                      return Expanded(
                        child: bookWidget(text: "Pending",
                            onTap:(){homeController.updateSelectTextValue("Pending");},
                            color:
                            homeController.selectValueText.value=="Pending"?
                            AppColor.white:AppColor.primaryColor,
                            backColor:
                            homeController.selectValueText.value=="Pending"?AppColor.primaryColor:
                            AppColor.transParent
                        ),
                      );
                    }
                ),
                SizedBox(width: Get.width*0.03,),
                Obx(
                        () {
                      return Expanded(
                        child: bookWidget(text: "Active",
                            onTap:(){homeController.updateSelectTextValue("act");},
                            color:
                            homeController.selectValueText.value=="act"?
                            AppColor.white:AppColor.primaryColor,
                            backColor:
                            homeController.selectValueText.value=="act"?AppColor.primaryColor:
                            AppColor.transParent
                        ),
                      );
                    }
                ),
                SizedBox(width: Get.width*0.03,),
                Obx(
                        () {
                      return Expanded(
                        child: bookWidget(text: "Complete",
                            onTap:(){homeController.updateSelectTextValue("comp");},
                            color:
                            homeController.selectValueText.value=="comp"?
                            AppColor.white:AppColor.primaryColor,
                            backColor:
                            homeController.selectValueText.value=="comp"?AppColor.primaryColor:
                            AppColor.transParent
                        ),
                      );
                    }
                ),
                SizedBox(width: Get.width*0.03,),

                Obx(
                  () {
                    return Expanded(
                      child: bookWidget(text: "Cancel",
                          onTap:(){homeController.updateSelectTextValue("cancel");},
                          color:
                          homeController.selectValueText.value=="cancel"?
                          AppColor.white:AppColor.primaryColor,
                          backColor:
                          homeController.selectValueText.value=="cancel"?AppColor.primaryColor:
                          AppColor.transParent
                      ),
                    );
                  }
                ),


              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),

         Obx(
           () {
             return Expanded(child: SingleChildScrollView(
               child: Column(
                 children: [
                   homeController.isOrderLoading.value
                       ?ListView.builder(
                       shrinkWrap: true,
                       primary: false,
                       physics: BouncingScrollPhysics(),
                       padding: EdgeInsets.zero,
                       itemCount: 12,
                       itemBuilder: (BuildContext context, int index) {
                         return  Container(
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                           margin: const EdgeInsets.only( bottom: 10),
                           child: getShimmerLoading(),
                         );
                       })
                       :
                       homeController.selectValueText.value=="Pending"?
                           PendingList():

                       homeController.selectValueText.value=="comp"?
                       CompletedList():
                       homeController.selectValueText.value=="cancel"?
                       CancelList():
                       ActiveList()
                 ],
               ),
             ));
           }
         )



          ],
        ),
      ),
    );
  }

  Widget bookWidget({text,color,backColor,onTap}){
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(30),
          color: backColor
        ),
        child:  Padding(
          padding:  EdgeInsets.symmetric(horizontal:Get.width*0.02 ,vertical:Get.height*0.013),
          child: Center(
            child: AppText(
              title: text,
              size: AppSizes.size_11,
              overFlow: TextOverflow.ellipsis,
              maxLines: 1,
              fontFamily: AppFont.semi,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}


