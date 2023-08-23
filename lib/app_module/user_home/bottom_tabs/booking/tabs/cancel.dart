import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';

class CancelList extends StatelessWidget {
  CancelList({Key? key}) : super(key: key);
  final homeController  = Get.put(UserController());
  String formatTime(String time24) {
    final parsedTime = DateFormat('HH:mm:ss').parse(time24);
    final formattedTime = DateFormat('h:mm a').format(parsedTime);
    return formattedTime;
  }
  @override
  Widget build(BuildContext context) {
    return
      Obx(
              () {
            return
              homeController.getBookList.where((p0) => p0.status=="cancelled").toList().isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: homeController.getBookList.where((p0) => p0.status=="cancelled").toList().length,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime date = DateTime.parse(
                        homeController.getBookList.where((p0) => p0.status=="cancelled").toList()[index].date??""

                    );


                    final formattedTime = formatTime( homeController.getBookList.where((p0) => p0.status=="cancelled").toList()[index].start.toString());
                    return
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor.primaryColor)
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.006,
                                ),
                                AppText(
                                  title: "${DateFormat('dd MMM, yyyy').format(
                                      date
                                  )} - ${formattedTime.toString()}",
                                  size: AppSizes.size_12,
                                  overFlow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackDarkColor,
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                Divider(color: AppColor.greyLightColor,),
                                ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: homeController.getBookList.where((p0) => p0.status=="cancelled").toList()[index].services?.length,
                                    itemBuilder: (BuildContext context, int i) {

                                      return Padding(
                                        padding:  EdgeInsets.symmetric(vertical: Get.height*0.008),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration:BoxDecoration(
                                                  border: Border.all(color: AppColor.primaryColor,


                                                  ),
                                                borderRadius: BorderRadius.circular(1000),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(1000),
                                                child:CachedNetworkImage(
                                                  placeholder: (context, url) =>   Center(
                                                    child: SpinKitThreeBounce(
                                                        size: 15,
                                                        color: AppColor.primaryColor
                                                    ),
                                                  ),
                                                  imageUrl:homeController.getBookList.where((p0) => p0.status=="cancelled").toList()[index].services![i].image.toString(),
                                                  height: Get.height * 0.067,
                                                  width: Get.height * 0.067,
                                                  fit: BoxFit.cover,

                                                  errorWidget: (context, url, error) => Image.asset(
                                                    "assets/images/default.png",
                                                    fit: BoxFit.cover,
                                                    height: Get.height * 0.067,
                                                    width: Get.height * 0.067,
                                                  ),
                                                ),




                                              ),
                                            ),
                                            SizedBox(width: Get.width*0.02,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  title:homeController.getBookList.where((p0) => p0.status=="cancelled").toList()[index].services![i].name.toString(),
                                                  size: AppSizes.size_14,
                                                  fontFamily: AppFont.medium,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.blackColor,
                                                ),
                                                SizedBox(height: Get.height*0.004,),
                                                AppText(
                                                  title: "\$${homeController.getBookList.where((p0) => p0.status=="cancelled").toList()[index].services![i].price.toString()}",
                                                  size: AppSizes.size_12,
                                                  overFlow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  fontFamily: AppFont.medium,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.greyColors,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                Divider(color: AppColor.greyLightColor,),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      title: "Total Amount",
                                      size: AppSizes.size_13,
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackDarkColor,
                                    ),
                                    AppText(
                                      title: "\$${homeController.getBookList.where((p0) => p0.status=="cancelled").toList()[index].total.toString()}",
                                      size: AppSizes.size_14,
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.blackDarkColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.012,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [


                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.redColor),
                                          borderRadius: BorderRadius.circular(30),
                                        color: AppColor.redColor
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
                                        child: Center(
                                          child: AppText(
                                            title: "Booking Cancel",
                                            size: AppSizes.size_13,
                                            overFlow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            fontFamily: AppFont.medium,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  }):noData();;
          }
      );
  }
}
