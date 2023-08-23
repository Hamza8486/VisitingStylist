import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stylish_app/app_module/stylish_home/controller/stylish_controller.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_booking/component/component.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_booking/component/view_booking.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';
import 'package:stylish_app/widgets/polyline.dart';

class NewJobsList extends StatelessWidget {
   NewJobsList({Key? key}) : super(key: key);
  final homeController  = Get.put(StylishController());
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
          homeController.getNewJobList.isNotEmpty?

          ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount:  homeController.getNewJobList.length,
            itemBuilder: (BuildContext context, int index) {
              DateTime date = DateTime.parse(
                  homeController.getNewJobList[index].booking?.date??""

              );


              final formattedTime = formatTime(  homeController.getNewJobList[index].booking!.start.toString());
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              GestureDetector(
                                onTap: (){
                                  Get.put(StylishController()).updateLat(Get.put(StylishController()).getProfile.lat);
                                  Get.put(StylishController()).updateLng(Get.put(StylishController()).getProfile.long);
                                  Get.put(StylishController()).updateEndLat(homeController.getNewJobList[index].booking?.lat.toString());
                                  Get.put(StylishController()).updateEndLng(homeController.getNewJobList[index].booking?.long.toString());

                                  Get.to(MapWithPolyline());
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Text("See on map",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: AppSizes.size_13,

                                    fontFamily: AppFont.bold,

                                    color: AppColor.primaryColor,
                                  ),
                                  ),
                                ),
                              ),
                            ],
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
                              itemCount:homeController.getNewJobList[index].booking!.services?.length,
                              itemBuilder: (BuildContext context, int i) {

                                return Padding(
                                  padding:  EdgeInsets.symmetric(vertical: Get.height*0.008),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration:BoxDecoration(
                                            border: Border.all(color: AppColor.primaryColor,


                                            ),
                                            borderRadius:BorderRadius.circular(1000)
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
                                            imageUrl:homeController.getNewJobList[index].booking!.services![i].image.toString(),
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
                                            title:homeController.getNewJobList[index].booking!.services![i].name.toString(),
                                            size: AppSizes.size_13,
                                            fontFamily: AppFont.medium,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.blackColor,
                                          ),
                                          SizedBox(height: Get.height*0.004,),
                                          AppText(
                                            title: "\$${homeController.getNewJobList[index].booking!.services![i].price.toString()}",
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
                                title: "\$${homeController.getNewJobList[index].booking?.total.toString()}",
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
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){

                                      FocusScope.of(context).unfocus();
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          isDismissible: true,
                                          context: context,
                                          builder: (context) =>  RejectBootmSheet(id: homeController.getNewJobList[index].id.toString(),
                                          text: "Reject",
                                          text1: "Reject",
                                          text2: "reject",
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.primaryColor),
                                          color: AppColor.primLightColor,
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                                        child: Center(
                                          child: AppText(
                                            title: "Reject booking",
                                            size: AppSizes.size_13,
                                            overFlow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            fontFamily: AppFont.medium,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width*0.04,),

                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){

                                      Get.to(ViewBooking(data:homeController.getNewJobList[index] ,
                                      type: "new",
                                      ),
                                      transition: Transition.rightToLeft
                                      );
                                      // FocusScope.of(context).unfocus();

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.primaryColor),
                                          borderRadius: BorderRadius.circular(30),
                                          color: AppColor.primaryColor
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                                        child: Center(
                                          child: AppText(
                                            title: "More Detail",
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
                                  ),
                                ),



                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            }):noData();
      }
    );
  }
}
