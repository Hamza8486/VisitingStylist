import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';


class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

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
                  title: "Payment History",
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
                            Get.put(UserController()).isPaymentLoading.value?Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: Get.height * 0.35),
                                Center(
                                    child: SpinKitThreeBounce(
                                        size: 20, color: AppColor.primaryColor)),
                              ],
                            ):
                            Get.put(UserController()).paymentList.isNotEmpty?

                            ListView.builder(
                                itemCount: Get.put(UserController()).paymentList.length,
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
                                            children: [
                                              AppText(
                                                title:"Id : ",
                                                size: AppSizes.size_14,
                                                fontFamily: AppFont.semi,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.blackColor,
                                              ),
                                              AppText(
                                                title:Get.put(UserController()).paymentList[index].transactionId.toString(),
                                                size: AppSizes.size_15,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.blackColor.withOpacity(0.7),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Get.height*0.01,),
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
                                                    title: "\$${Get.put(UserController()).paymentList[index].amount.toString()}",
                                                    size: AppSizes.size_15,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ],
                                              ),
                                              AppText(
                                                title: Get.put(UserController()).paymentList[index].time.toString(),
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
                                }):noData(height: Get.height*0.35);
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
