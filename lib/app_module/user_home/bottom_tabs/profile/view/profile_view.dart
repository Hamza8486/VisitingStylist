import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/login.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/profile/component/edit_profile.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/profile/component/help_center.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/profile/component/my_transactions.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/profile/component/privacy.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.05),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Center(
                      child: AppText(
                        title: "Profile",
                        color: AppColor.blackColor,
                        size: AppSizes.size_20,
                        fontFamily: AppFont.semi,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.055,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Obx(() {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.132,
                              width: MediaQuery.of(context).size.height * 0.132,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  Get.put(UserController()).image.value.isNotEmpty?  BorderRadius.circular(100):
                                  BorderRadius.circular(100),
                                  border:
                                      Border.all(color: AppColor.primaryColor, width: 2)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Obx(
                                  () {
                                    return


                                      CachedNetworkImage(
                                      placeholder: (context, url) =>Center(
                                          child: SpinKitThreeBounce(
                                              size: 16, color: AppColor.black)
                                      ),
                                      imageUrl:Get.put(UserController()).image.value,
                                      fit: Get.put(UserController()).name.value.isEmpty
                                          ? BoxFit.cover
                                          : BoxFit.cover,
                                      errorWidget: (context, url, error) => ClipRRect(
                                        borderRadius:


                                        BorderRadius.circular(100),
                                        child: Image.asset(
                                          'assets/images/person.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ),
                            );
                          }),
                          Positioned(
                              bottom: 10,
                              right: 0,
                              child: Image.asset(
                                "assets/images/change.png",
                                height: Get.height * 0.03,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Obx(
                      () {
                        return AppText(
                          title:"${Get.put(UserController()).nameFirst.value} ${Get.put(UserController()).last.value}",
                          size: AppSizes.size_17,
                          overFlow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontFamily: AppFont.semi,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackDarkColor,
                        );
                      }
                    ),
                    Obx(
                      () {
                        return AppText(
                          title: Get.put(UserController()).email.value,
                          size: AppSizes.size_14,
                          overFlow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.greyLightColor,
                        );
                      }
                    ),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: AppColor.greyLightColor.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),
                    profileWidget(
                      onTap: () {
                        Get.put(AuthController()).clearAllController();
                        Get.put(AuthController()).clearCompleteProfile();

                        Get.to(EditProfile(),
                        transition: Transition.rightToLeft
                        );
                      },
                      image: "assets/icons/prof.svg",
                      text: "Edit Profile",
                    ),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),
                    profileWidget(
                      onTap: () {
                        Get.put(UserController()).getPaymentData();


                        Get.to(TransactionList(),
                            transition: Transition.rightToLeft
                        );
                      },
                      image: "assets/icons/wallet.svg",
                      text: "Payment History",
                    ),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),
                    profileWidget(
                      onTap: () {
                        Get.to(PrivacyPolicy(),
                            transition: Transition.rightToLeft
                        );
                      },
                      image: "assets/icons/pri.svg",
                      text: "Privacy",
                    ),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),
                    profileWidget(
                      onTap: () {
                        Get.to(HelpCenter(),
                            transition: Transition.rightToLeft
                        );
                      },
                      image: "assets/icons/help.svg",
                      text: "Help",
                    ),

                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                showExitPopupMain(context,
                        ()async{
                          Get.find<UserController>().clearState();
                          Get.put(AuthController()).clearAllController();
                          Get.put(AuthController()).clearCompleteProfile();
                          ApiManger().logoutUser();
                          Get.put(AuthController()).clear();
                          Get.put(AuthController()).clearLogin();

                          await HelperFunctions().clearPrefs();
                          Get.offAll(LoginView());
                    }
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(
                      color:
                      AppColor.redColor,
                      width: 1.7
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12, vertical: Get.height * 0.016),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/logout.svg"),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      AppText(
                        title: "Log Out",
                        size: AppSizes.size_14,
                        fontFamily: AppFont.bold,
                        color: AppColor.redColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileWidget({text, image, Widget? child, onTap, Widget? childs,
Color?color
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              childs ??
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      child: SvgPicture.asset(
                        image,
                        height: Get.height * 0.032,
                      ),
                    ),
                  ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              AppText(
                title: text,
                fontFamily: AppFont.medium,
                size: AppSizes.size_15,
                fontWeight: FontWeight.w600,
                color:color?? AppColor.boldBlackColor,
              ),
            ],
          ),
          child ??
              SvgPicture.asset(
                "assets/icons/arrow.svg",
                height: Get.height * 0.015,
              ),
        ],
      ),
    ),
  );
}
