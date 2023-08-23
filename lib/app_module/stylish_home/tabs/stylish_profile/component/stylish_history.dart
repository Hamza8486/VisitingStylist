import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/stylish_home/controller/stylish_controller.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';
import 'package:url_launcher/url_launcher.dart';



class StylishTransactionList extends StatelessWidget {
  const StylishTransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04, vertical: Get.height * 0.03),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(

              children: [
                backButton(
                    onTap: (){

                      Get.back();
                    }
                ),
                SizedBox(width: Get.width*0.18,),
                AppText(
                  title: "Payments",
                  color: AppColor.blackColor,
                  size: AppSizes.size_18,
                  fontFamily: AppFont.semi,
                ),
                Container()
              ],
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Obx(
                            () {
                          return
                            Get.put(StylishController()).isPaymentLoading.value?Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: Get.height * 0.35),
                                Center(
                                    child: SpinKitThreeBounce(
                                        size: 20, color: AppColor.primaryColor)),
                              ],
                            ):
                            Get.put(StylishController()).account.value==false?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: Get.height*0.35,),
                                Center(
                                  child: AppText(title: Get.put(StylishController()).paymentText.value,
                                  fontFamily: AppFont.medium,
                                    size: AppSizes.size_14,
                                    textAlign: TextAlign.center,
                                    color: AppColor.boldBlackColor,
                                  ),
                                ),
                                SizedBox(height: Get.height*0.02,),
                                GestureDetector(
                                  onTap:(){
                                    launch("https://visitingstylist.fgn.lcg.mybluehost.me");
                                  },
                                  child: Container(
                                    decoration:BoxDecoration(color:
                                    AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5.5),
                                      child: AppText(
                                        title:"Go to Web",
                                        size: AppSizes.size_14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: AppFont.semi,
                                        color: AppColor.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ):

                            (Get.put(StylishController()).paymentList.isNotEmpty?

                            ListView.builder(
                                itemCount: Get.put(StylishController()).paymentList.length,
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {

                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 9),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                             Row(
                                               children: [
                                                 AppText(
                                                   title:"Booking Id : ",
                                                   size: AppSizes.size_14,
                                                   fontFamily: AppFont.semi,
                                                   fontWeight: FontWeight.w600,
                                                   color: AppColor.blackColor,
                                                 ),
                                                 AppText(
                                                   title:Get.put(StylishController()).paymentList[index].bookingId.toString(),
                                                   size: AppSizes.size_15,
                                                   fontFamily: AppFont.medium,
                                                   fontWeight: FontWeight.w500,
                                                   color: AppColor.blackColor.withOpacity(0.7),
                                                 ),
                                               ],
                                             ),
                                              Container(
                                                decoration:BoxDecoration(color:

                                                Get.put(StylishController()).paymentList[index].status=="pending"?

                                                Colors.orangeAccent:

                                                Get.put(StylishController()).paymentList[index].status=="completed"?

                                                Colors.green:
                                                Colors.red,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5.5),
                                                  child: AppText(
                                                    title:
                                                    Get.put(StylishController()).paymentList[index].status=="pending"?"Pending":
                                                    Get.put(StylishController()).paymentList[index].status=="completed"?"Completed":

                                                    Get.put(StylishController()).paymentList[index].status.toString(),
                                                    size: AppSizes.size_14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: AppFont.semi,
                                                    color: AppColor.white.withOpacity(0.8),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Get.height*0.012,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  AppText(
                                                    title:"Amount : ",
                                                    size: AppSizes.size_14,
                                                    fontFamily: AppFont.semi,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.blackColor,
                                                  ),
                                                  AppText(
                                                    title: "\$${Get.put(StylishController()).paymentList[index].amount.toString()}",
                                                    size: AppSizes.size_15,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ],
                                              ),
                                              AppText(
                                                title: Get.put(StylishController()).paymentList[index].time.toString(),
                                                size: AppSizes.size_13,
                                                fontFamily: AppFont.regular,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.blackColor,
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  );
                                }):noData(height: Get.height*0.35));
                        }
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
