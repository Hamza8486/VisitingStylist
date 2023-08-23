import 'dart:developer';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_app/app_module/authentication/address.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/component.dart';
import 'package:stylish_app/app_module/stylish_home/controller/stylish_controller.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/bottom_sheet.dart';
import 'package:stylish_app/widgets/helper_function.dart';




class StylishEditProfile extends StatefulWidget {
  StylishEditProfile({Key? key}) : super(key: key);

  @override
  State<StylishEditProfile> createState() => _StylishEditProfileState();
}

class _StylishEditProfileState extends State<StylishEditProfile> {
  final authController = Get.put(AuthController());


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
  authController.fullNameController.text=Get.find<StylishController>().nameFirst.value;
  authController.lastNameController.text=Get.find<StylishController>().last.value;
  authController.phoneController.text=Get.find<StylishController>().getProfile.phone==null?"":Get.find<StylishController>().getProfile.phone;
  authController.emailRegController.text=Get.find<StylishController>().email.value;
  authController.addressController.text=Get.find<StylishController>().getProfile.address==null?"":Get.find<StylishController>().getProfile.address;
  authController.postalController.text=Get.find<StylishController>().getProfile.postCode==null?"":Get.find<StylishController>().getProfile.postCode;
  authController.updateLat(Get.find<StylishController>().getProfile.lat.toString());
  authController.updateLng(Get.find<StylishController>().getProfile.long.toString());

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
                          Get.put(AuthController()).clearCompleteProfile();
                          Get.put(AuthController()).clearAllController();
                          Get.back();
                        }
                    ),
                    SizedBox(width: Get.width*0.2,),
                    AppText(
                      title: "Edit Profile",
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
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (builder) => bottomSheet(onCamera: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.camera)
                                      .then((value) {
                                    setState(() {
                                      Get.find<StylishController>().file = value!;
                                    });
                                  });
                                }, onGallery: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      Get.find<StylishController>().file = value!;
                                    });
                                  });
                                }));
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: Get.width,
                                height: Get.height * 0.15,
                                child: Center(
                                  child: Material(
                                    elevation: 1,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                    ),
                                    color: AppColor.primaryColor,
                                    child: Container(
                                      height: Get.height * 0.139,
                                      width: Get.height * 0.139,
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(100))),
                                      child: Get.find<StylishController>().file == null
                                          ? Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child: Obx(
                                                  () {
                                                return Image.network(
                                                  Get.find<StylishController>().image.value ,
                                                  fit: Get.find<StylishController>().image.value.isEmpty?BoxFit.cover: BoxFit.cover,
                                                  errorBuilder: (context, exception,
                                                      stackTrace) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      child: Image.asset(
                                                        "assets/images/person.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                          ),
                                        ),
                                      )
                                          : Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child: Image.file(
                                            Get.find<StylishController>().file as File,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: Get.width * 0.51,
                                  top: Get.height * 0.11,
                                  child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColor.primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Icon(Icons.camera_alt_sharp,
                                        color: Colors.white,
                                          size: Get.height*0.023,
                                        )
                                      )))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),


                        textAuth(text: "First Name",color: Colors.red),
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
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: "last Name",color: Colors.red),
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
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: "Email",color: Colors.red),
                        Align
                          (
                          alignment: Alignment.topLeft,
                          child: AppText(
                            title: "(Do not change)",
                            size:AppSizes.size_12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFont.regular,
                            color: AppColor.greyColors,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        stylishField( validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : "Please enter a valid email",
                            hint: "Example@gmail.com",
                            isRead:
                            true,
                            cur:
                            false,
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
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: "phone number",color: Colors.red),
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
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: "Service Address",color: Colors.red),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                    stylishField(
                      onTap: (){
                        Get.to(AddAddress());
                      },
                        hint:
                        "Select Address",
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
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: "Postal Code",color: Colors.red),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        stylishField(
                            hint: "123456",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter postal code';
                              }
                              if (value.length<3) {
                                return 'Please enter valid postal code';
                              }

                              return null;
                            },

                            textInputType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
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
                          height: Get.height * 0.017,
                        ),

                      ],
                    ),
                  ),
                ),
                isKeyBoard?SizedBox.shrink():
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(30),
                        buttonName: "Update Profile",


                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_14,
                        fontFamily: AppFont.medium,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if(validateProfile(context)){
                            authController.updateLoader(true);
                            ApiManger().editProfileResponse1();
                          }



                        }),

                    SizedBox(
                      height: Get.height * 0.012,
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


  bool validateProfile(BuildContext context) {

    if (authController.fullNameController.text.isEmpty) {
      flutterToast(msg: "Please enter first name");
      return false;
    }
    if (authController.lastNameController.text.isEmpty) {
      flutterToast(msg: "Please enter last name");
      return false;
    }
    if (authController.phoneController.text.isEmpty) {
      flutterToast(msg: "Please enter phone number");
      return false;
    }
    if (authController.addressController.text.isEmpty) {
      flutterToast(msg: "Please enter address");
      return false;
    }
    if (authController.postalController.text.isEmpty) {
      flutterToast(msg: "Please enter postal code");
      return false;
    }






    return true;
  }
}
