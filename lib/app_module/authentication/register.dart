import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/address.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/component.dart';
import 'package:stylish_app/app_module/authentication/login.dart';
import 'package:stylish_app/app_module/authentication/terms.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';




class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: AppPaddings.mainPadding,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [



                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Image.asset("assets/images/logo.png",
                            height: Get.height*0.085,
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Obx(
                            () {
                              return AppText(
                                title:
                                authController.userType.value=="client"?"Signup to User":
                                "Signup to Stylist",
                                size: AppSizes.size_18,
                                fontFamily: AppFont.semi,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackDarkColor,
                              );
                            }
                          ),
                          SizedBox(
                            height: Get.height * 0.003,
                          ),

                          AppText(
                            title: "Enter your information to create account!",
                            size: AppSizes.size_13,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.greyLightColor,
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          textAuth(text: "First Name",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          stylishField(

                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter first name';
                                }
                                if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                                  return null;
                                }
                                return null;
                              },
                              hint: "David",
                              controller: authController.fullNameController,
                              child1: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: SvgPicture.asset("assets/icons/profile.svg",
                                  height: Get.height*0.01,
                                ),
                              ),
                              isSuffix: true
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          textAuth(text: "last Name",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          stylishField(


                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter last name';
                                }
                                if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                                  return null;
                                }
                                return null;
                              },
                              hint: "David",
                              controller: authController.lastNameController,
                              child1: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: SvgPicture.asset("assets/icons/profile.svg",
                                  height: Get.height*0.01,
                                ),
                              ),
                              isSuffix: true
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          textAuth(text: "phone number",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          stylishField(
                              hint: "(800) 456-7890",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter phone number';
                                }
                                if (value.length<8) {
                                  return 'Please enter valid phone number';
                                }

                                return null;
                              },

                              textInputType: TextInputType.phone,
                              controller: authController.phoneController,
                              child1: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: SvgPicture.asset("assets/icons/call.svg",
                                  height: Get.height*0.01,
                                ),
                              ),
                              isSuffix: true
                          ),

                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          textAuth(text: "Email",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          stylishField( validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email",
                              hint: "Example@gmail.com",
                              controller: authController.emailRegController,
                              child1: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: SvgPicture.asset("assets/icons/message.svg",
                                  height: Get.height*0.01,
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              isSuffix: true
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          textAuth(text: "Service Address",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          stylishField(
                              onTap:

                                  (){
                                FocusScope.of(context).unfocus();
                                Get.to(AddAddress());
                              },
                              hint:
                              "Select Address",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter address';
                                }


                                return null;
                              },

                              isRead:
                            true,
                              cur:
                             false,

                              textInputType: TextInputType.streetAddress,
                              controller: authController.addressController,
                              child1: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset("assets/icons/loc.png",
                                  height: Get.height*0.01,
                                ),
                              ),
                              isSuffix: true
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          textAuth(text: "Postal Code",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          stylishField(
                              hint: "Postal Code",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter postal code';
                                }
                                if (value.length<3) {
                                  return 'Please enter valid postal code';
                                }

                                return null;
                              },

                              textInputType: TextInputType.text,
                              controller: authController.postalController,
                              child1: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset("assets/icons/loc.png",
                                  height: Get.height*0.01,
                                ),
                              ),
                              isSuffix: true
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          textAuth(text: "Password",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          Obx(() {
                            return stylishField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is required';
                                }
                                if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9]).*$').hasMatch(value)) {
                                  return 'Password must contain at least letter and number';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
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
                              obscure: authController.isVisible1.value,
                              controller: authController.passRegController,
                              child:    IconButton(
                                  onPressed: () {
                                    authController.updateVisible1Status();
                                  },
                                  icon: Icon(
                                      authController.isVisible1.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: Get.height * 0.022,
                                      color: AppColor.blackColor)),
                            );
                          }),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Obx(() {
                            return termsAndCondition(
                                color: authController.isAllCheck.value == false
                                    ? Colors.transparent
                                    : AppColor.primaryColor,
                                color1: AppColor.primaryColor,
                                onTap: () {
                                  if (authController.isAllCheck.value == false) {
                                    authController.updateAllCheck(true);
                                  } else {
                                    authController.updateAllCheck(false);
                                  }
                                },
                                color2: authController.isAllCheck.value == false
                                    ? Colors.transparent
                                    : Colors.white);
                          }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                isKeyBoard?SizedBox.shrink():
               Column(
                 children: [
                   SizedBox(
                     height: Get.height * 0.015,
                   ),
                   AppButton(
                       buttonWidth: Get.width,
                       buttonRadius: BorderRadius.circular(30),
                       buttonName: "Continue",


                       fontWeight: FontWeight.w500,
                       textSize: AppSizes.size_14,
                       fontFamily: AppFont.medium,
                       buttonColor: AppColor.primaryColor,
                       textColor: AppColor.whiteColor,
                       onTap: () {


                         if (formKey.currentState!.validate()) {

                           if (authController.isAllCheck.value == false) {
                             flutterToast(
                               msg:"Please accept terms and conditions to continue",


                             );
                           }
                           else{
                             authController.updateLoader(true);
                             ApiManger().registerResponse(context: context,token:token.toString());
                           }




                         }

                       }),

                   SizedBox(
                     height: Get.height * 0.012,
                   ),
                   Center(
                     child: GestureDetector(
                       onTap: () {
                         Get.put(AuthController()).clear();
                         Get.put(AuthController()).clearCompleteProfile();
                         Get.put(AuthController()).clearLogin();
                         Get.off(LoginView());
                       },
                       child: RichText(
                         text: TextSpan(
                           text: "Already have an account ? ",
                           style: TextStyle(
                               color: AppColor.greyLightColor,
                               fontFamily: AppFont.regular,
                               fontWeight: FontWeight.w500,
                               fontSize: AppSizes.size_14),
                           children: <TextSpan>[
                             TextSpan(
                                 text: "Sign in",
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
                   SizedBox(
                     height: Get.height * 0.005,
                   ),
                 ],
               )
              ],
            ),
          ),
        ),
        Obx(() {
          return authController.loader.value == false
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
Widget termsAndCondition({onTap,color,color1,color2}){
  return  Row(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: Get.height*0.021,
          width: Get.height*0.021,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(color: color1),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Center(child: Icon(Icons.check,color: color2,
            size: Get.height*0.018,
          )),
        ),
      ),
      SizedBox(width: Get.width*0.022,),
      GestureDetector(
        onTap: (){
          Get.to(TermsCondtionView(),
              transition: Transition.rightToLeft
          );
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              AppText(
                  title:
                  "I agree to the",

                  color: AppColor.blackColor,
                  fontFamily: AppFont.medium,
                  size: AppSizes.size_13),
              Text("Terms & Conditions",style: TextStyle(color: AppColor.primaryColor,fontFamily: AppFont.semi,
                  decoration: TextDecoration.underline,fontSize: AppSizes.size_13),),
            ],
          ),
        ),
      )

    ],
  );
}