import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/register.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';




class UserType extends StatelessWidget {
  UserType({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Padding(
        padding: AppPaddings.mainPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height*0.035,),
              backButton(
                onTap: (){
                  Get.put(AuthController()).clear();
                  Get.put(AuthController()).clearCompleteProfile();
                  Get.put(AuthController()).clearLogin();
                  Get.back();
                }
              ),

              SizedBox(height: Get.height*0.3,),
              Center(
                child: AppText(
                  title: "Signup as",
                  size: AppSizes.size_18,
                  fontFamily: AppFont.semi,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackDarkColor,
                ),
              ),
              SizedBox(height: Get.height*0.03,),

              GestureDetector(
                onTap: (){

                  Get.put(AuthController()).updateUserType("client");
                  Get.put(AuthController()).updateAllCheck(false);
                  Get.put(AuthController()).clear();
                  Get.put(AuthController()).clearCompleteProfile();
                  Get.put(AuthController()).clearLogin();
                  Get.to(RegisterView(),
                      transition: Transition.rightToLeft
                  );
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.strokeColor),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        AppText(
                            title: "User/client",
                            color: AppColor.blackDarkColor,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w600,
                            size: AppSizes.size_13),
                        Image.asset("assets/images/user.png",
                          height: Get.height*0.028,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.03,),
              GestureDetector(
                onTap: (){
                  Get.put(AuthController()).updateUserType("stylist");
                  Get.put(AuthController()).updateAllCheck(false);

                  Get.put(AuthController()).clear();
                  Get.put(AuthController()).clearCompleteProfile();
                  Get.put(AuthController()).clearLogin();
                  Get.to(RegisterView(),
                      transition: Transition.rightToLeft
                  );
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.strokeColor),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        AppText(
                            title: "Stylist",
                            color: AppColor.blackDarkColor,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w600,
                            size: AppSizes.size_13),
                        Image.asset("assets/images/client.png",
                          height: Get.height*0.028,
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],


        ),
      ),
    )
    );
  }
}
