import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/component.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/app_textfield.dart';



class NewPassword extends StatelessWidget {
  NewPassword({Key? key,this.id}) : super(key: key);
  var id;
  final authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordNewController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async =>

      false,
      child: Scaffold(

        body: Padding(
          padding: AppPaddings.mainPadding,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height*0.035,),
                  backButton(
                      onTap: (){
                       Navigator.pop(context);
                       Navigator.pop(context);
                        Get.put(AuthController()).clear();
                        Get.put(AuthController()).clearCompleteProfile();
                        Get.put(AuthController()).clearLogin();
                      }
                  ),
                  SizedBox(height: Get.height*0.02,),
                  AppText(title: "Create New Password",
                    size: AppSizes.size_20,
                    fontFamily: AppFont.semi,
                    color: AppColor.boldBlackColor,
                  ),
                  SizedBox(height: Get.height*0.008,),
                  AppText(title: "Your password must be different from previous used password.",
                    size: AppSizes.size_13,
                    fontFamily: AppFont.regular,
                    textAlign: TextAlign.justify,
                    color: AppColor.textGreyColor,
                  ),
                  SizedBox(height: Get.height*0.03,),
                  textAuth(text: "Password"),

                  SizedBox(height: Get.height*0.01,),
                  Obx(() {
                    return AppTextFied(


                      isborderline: true,
                      obsecure: authController.isVisible1.value,
                      borderColor:AppColor.borderColorField,
                      controller: passwordController,
                      isborderline2: true,
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                            isVisible: true,
                      isSuffix: true,
                      autovalidateMode:  AutovalidateMode.onUserInteraction,
                      suffixIcon: IconButton(onPressed: (){
                        authController.updateVisible1Status();
                      }, icon: Icon(
                          authController.isVisible1.value ? Icons.visibility_off : Icons.visibility,
                          size: Get.height*0.022,
                          color: AppColor.blackColor),),
                      hintSize: AppSizes.size_13,

                      borderRadius: BorderRadius.circular(10),
                      borderRadius2: BorderRadius.circular(10),
                      hint: "Password",



                      borderColor2: AppColor.primaryColor,
                      maxLines: 1,
                      hintColor: AppColor.greyColors,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,

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
                    );
                  }
                  ),
                  SizedBox(height: Get.height*0.025,),
                  textAuth(text: "Confirm Password"),

                  SizedBox(height: Get.height*0.01,),
                  Obx(() {
                    return AppTextFied(
                      isborderline: true,
                      hintSize: AppSizes.size_13,
                      obsecure: authController.isVisible2.value,
                      borderColor:AppColor.borderColorField,
                      controller: passwordNewController,
                      isborderline2: true,
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0185),                            isVisible: true,
                      isSuffix: true,
                      autovalidateMode:  AutovalidateMode.onUserInteraction,
                      suffixIcon: IconButton(onPressed: (){
                        authController.updateVisible2Status();
                      }, icon: Icon(
                          authController.isVisible2.value ? Icons.visibility_off : Icons.visibility,
                          size: Get.height*0.022,
                          color: AppColor.blackColor),),
                      fontFamily:AppFont.regular,
                      borderRadius: BorderRadius.circular(10),
                      borderRadius2: BorderRadius.circular(10),
                      hint: "Confirm Password",
                      hintColor: AppColor.greyColors,


                      borderColor2: AppColor.primaryColor,
                      maxLines: 1,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,

                      validator: (value) {
                        if (value !=
                            passwordController.text) {
                          return "Password does not match";
                        } else {
                          return null;
                        }
                      },
                    );
                  }
                  ),
                  SizedBox(height: Get.height*0.05,),



                  Obx(
                    () {
                      return
                        authController.loaderPassword.value?
                         Center(
                            child: SpinKitThreeBounce(
                                size: 20, color: AppColor.primaryColor)
                        )

                            :

                        AppButton(
                          buttonWidth: Get.width,
                          buttonRadius: BorderRadius.circular(10),
                          buttonName: "Recover Password", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap: (){


                        if (formKey.currentState!.validate()) {
                          authController.updatePasswordLoader(true);


                          ApiManger().changePassResponse(
                              context: context,
                              password: passwordController.text,
                              id: id.toString()
                          );
                          return;
                        }

                      });
                    }
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
