import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/user_dashboard/component/add_booking.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/user_dashboard/component/dash_components.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/app_module/user_home/view/user_home.dart';

import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';




class UserDashboard extends StatelessWidget {
  UserDashboard({Key? key}) : super(key: key);
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: Get.height*0.24,
          width: Get.width,
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)
              )

            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height*0.06,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(UserHome(currentIndex: 2,));
                        },
                        child: Container(
                          child: Row(

                            children: [
                              Container(
                                height: Get.size.height * 0.07,
                                width: Get.size.height * 0.07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    border: Border.all(
                                        color: AppColor.whiteColor, width: 1.5)),
                                child: Obx(
                                  () {
                                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(1000),
                                        child: CachedNetworkImage(
                                          imageUrl: userController.image.value,
                                          fit:
                                          userController.image.value.isEmpty?BoxFit.cover:

                                          BoxFit.cover,
                                          placeholder: (context, url) => const Center(
                                            child: SpinKitThreeBounce(
                                                size: 18, color: AppColor.primaryColor),
                                          ),
                                          errorWidget: (context, url, error) => ClipRRect(
                                            borderRadius: BorderRadius.circular(1000),
                                            child: Image.asset(
                                              "assets/images/person.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ));
                                  }
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    title: "Welcome back!",
                                    size: AppSizes.size_13,
                                    fontFamily: AppFont.medium,
                                    color: AppColor.boldBlackColor.withOpacity(0.5),
                                  ),
                                  Obx(() {
                                    return AppText(
                                      title: "${userController.nameFirst.value} ${userController.last.value}!",
                                      size: AppSizes.size_16,
                                      fontFamily: AppFont.semi,
                                      color: AppColor.boldBlackColor,
                                    );
                                  }),
                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                      SvgPicture.asset("assets/icons/noti.svg",
                        height: Get.height*0.03,
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height*0.014,),
                  Text("Let’s find",
                    style: TextStyle( fontSize: AppSizes.size_22,
                    // fontFamily: AppFont.semi,
                    //
                     fontWeight: FontWeight.w500,
                    color: AppColor.whiteColor,),),
                  SizedBox(height: Get.height*0.001,),

                  Text("Your Best Stylist",
                    style: TextStyle( fontSize: AppSizes.size_24,
                      // fontFamily: AppFont.semi,
                      //
                      fontWeight: FontWeight.w500,
                      color: AppColor.whiteColor,),),



                ],
              ),
            ),
          ),
          SizedBox(height: Get.height*0.015,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:Get.width*0.04 ),
            child: Text("Categories",style: TextStyle( fontSize: AppSizes.size_18,
              fontFamily: AppFont.semi,
              fontWeight: FontWeight.w600,
              color: AppColor.blackDarkColor,),),
          ),
          SizedBox(height: Get.height*0.01,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:Get.width*0.04 ),
            child: CategoryListDashboard(),
          ),
          SizedBox(height: Get.height*0.025,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:Get.width*0.04 ),
            child: Obx(
              () {
                return Text(
                  userController.name.value=="all"?
                  "All Services":"${userController.name.value.toString()} Services",style: TextStyle( fontSize: AppSizes.size_18,
                  fontFamily: AppFont.semi,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackDarkColor,),);
              }
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:Get.width*0.04 ),
                    child: Obx(
                      () {
                        return
                          userController.isServiceLoading.value?
                          ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: 12,
                              itemBuilder: (BuildContext context, int index) {
                                return  Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  margin: index==0?EdgeInsets.only( top: 0): EdgeInsets.only( top: 23),
                                  child:Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000),  color: Colors.white,),
                                          height: 60,
                                          width: 60,

                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 18.0,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 14.0,
                                                color: Colors.white,
                                              ),

                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }):
                          userController.serviceList.isNotEmpty?
                          ListView.builder(
                            itemCount: userController.serviceList.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:  EdgeInsets.symmetric(vertical: Get.height*0.01),
                                child: GestureDetector(
                                  onTap: (){
                                    Get.put(AuthController()).clearAllController();
                                    Get.put(AuthController()).clearCompleteProfile();
                                    Get.put(AuthController()).resetSelectedServices();
                                    Get.to(AddAppointment(),
                                    transition: Transition.rightToLeft
                                    );
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration:BoxDecoration(
                                                border: Border.all(color: AppColor.primaryColor,


                                                ),
                                                  borderRadius:BorderRadius.circular(1000)
                                              ),
                                              child: ClipRRect(
                                                borderRadius:BorderRadius.circular(1000),
                                                child:CachedNetworkImage(
                                                  placeholder: (context, url) =>  const Center(
                                                    child: SpinKitThreeBounce(
                                                        size: 15,
                                                        color: AppColor.primaryColor
                                                    ),
                                                  ),
                                                  imageUrl:userController.serviceList[index].image==null?"":userController.serviceList[index].image.toString(),
                                                  height: Get.height * 0.068,
                                                  width: Get.height * 0.068,
                                                  fit: BoxFit.cover,

                                                  errorWidget: (context, url, error) => Image.asset(
                                                    "assets/images/default.png",
                                                    fit: BoxFit.cover,
                                                    height: Get.height * 0.068,
                                                    width: Get.height * 0.068,
                                                  ),
                                                ),




                                              ),
                                            ),
                                            SizedBox(width: Get.width*0.03,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  title: userController.serviceList[index].name.toString(),
                                                  size: AppSizes.size_14,
                                                  fontFamily: AppFont.medium,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.blackColor,
                                                ),
                                                SizedBox(height: Get.height*0.00,),
                                                SizedBox(
                                                  width:Get.width*0.53,
                                                  child: AppText(
                                                    title:"\$ ${userController.serviceList[index].price.toString()}",
                                                    size: AppSizes.size_12,
                                                    overFlow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.greyColors,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 8),
                                          child: Text("Book Now",style: TextStyle(
                                            fontSize: Get.height*0.011,
                                            fontFamily: AppFont.semi,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.whiteColor,),),
                                        ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }):
                        noData(height: Get.height*0.15)
                        ;
                      }
                    ),
                  ),
                  SizedBox(height: Get.height*0.01,),
                ],
              ),
            ),
          )



        ],
      )
    );
  }
}
