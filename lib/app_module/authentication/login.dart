import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/component.dart';
import 'package:stylish_app/app_module/authentication/forget/view/forget_password.dart';
import 'package:stylish_app/app_module/authentication/social_login/view/social_login.dart';
import 'package:stylish_app/app_module/authentication/user_type.dart';
import 'package:stylish_app/app_module/user_home/view/user_home.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';




class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authController = Get.put(AuthController());

  final formKey = GlobalKey<FormState>();

  String? token;
  void getToken() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    HelperFunctions.saveInPreference("token", token!);
    log("token");
    log(token.toString());
  }

  int selectedPageIndex = 0;


  @override
  void initState() {

    super.initState();
    getToken();

  }
  var lat;
  var lng;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: AppPaddings.mainPadding,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [



                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Image.asset("assets/images/logo.png",
                    height: Get.height*0.085,
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    AppText(
                      title: "Signin to Stylist",
                      size: AppSizes.size_18,
                      fontFamily: AppFont.semi,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackDarkColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.002,
                    ),

                    AppText(
                      title: "We’re happy to see you back again!",
                      size: AppSizes.size_13,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyLightColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    textAuth(text: "Email",color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),
                    stylishField( validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                      hint: "Example@gmail.com",
                      controller: authController.emailController,
                      child1: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset("assets/icons/message.svg",
                        height: Get.height*0.01,
                        ),
                      ),
                      isSuffix: true
                    ),

                    SizedBox(
                      height: Get.height * 0.013,
                    ),
                    textAuth(text: "Password",color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),

                    Obx(() {
                      return stylishField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          // if(value.length<8)
                          // {
                          //   return 'Password must be greater then 8 character';
                          // }
                          return null;
                        },
                        hint: "Password",
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        child1: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset("assets/icons/password.svg",
                            height: Get.height*0.01,
                          ),
                        ),
                        obscure: authController.isVisible.value,
                        controller: authController.passController,
                        child:    IconButton(
                            onPressed: () {
                              authController.updateVisibleStatus();
                            },
                            icon: Icon(
                                authController.isVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: Get.height * 0.022,
                                color: AppColor.blackColor)),
                      );
                    }),

                    SizedBox(
                      height: Get.height * 0.013,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                       onTap: (){
                         Get.put(AuthController()).clear();
                         Get.put(AuthController()).clearCompleteProfile();
                         Get.put(AuthController()).clearLogin();
                         Get.to(ResetView(),
                         transition: Transition.rightToLeft
                         );
                       },
                        child: AppText(
                            title: "Forgot password?",
                            color: AppColor.greyLightColor,
                            fontFamily: AppFont.regular,
                            fontWeight: FontWeight.w400,
                            size: AppSizes.size_13),
                      ),
                    ),



                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(30),
                        buttonName: "Sign in",


                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_14,
                        fontFamily: AppFont.medium,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {

                          if (formKey.currentState!.validate()) {
                            authController.updateLoginLoader(true);
                            ApiManger().loginResponse(context: context,token:token.toString(),

                            );


                          }

                        }),

                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Image.asset("assets/images/other.png"),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal:Get.width*0.02 ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap:(){
                                AuthenticationHelper()
                                    .facebookSignIn(context: context, token: token);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.socialColor,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 11),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/facebook.png",
                                      height: Get.height*0.028,
                                      ),
                                      SizedBox(width: Get.width*0.025,),
                                      AppText(
                                          title: "Facebook",
                                          color: AppColor.blackDarkColor,
                                          fontFamily: AppFont.medium,
                                          fontWeight: FontWeight.w500,
                                          size: AppSizes.size_13)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width*0.03,),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                AuthenticationHelper()
                                    .googlebySignIn(context: context, token: token);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.socialColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 11),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/google.png",
                                        height: Get.height*0.028,
                                      ),
                                      SizedBox(width: Get.width*0.03,),
                                      AppText(
                                          title: "Google",
                                          color: AppColor.blackDarkColor,
                                          fontFamily: AppFont.medium,
                                          fontWeight: FontWeight.w500,
                                          size: AppSizes.size_13)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(UserType(),
                          transition: Transition.rightToLeft
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don’t have an account ?  ",
                            style: TextStyle(
                                color: AppColor.greyLightColor,
                                fontFamily: AppFont.regular,
                                fontWeight: FontWeight.w500,
                                fontSize: AppSizes.size_14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppSizes.size_16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          return authController.loaderLogin.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black26,
            child:  Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.black)
            ),
          );



        })
      ],
    );
  }
}
