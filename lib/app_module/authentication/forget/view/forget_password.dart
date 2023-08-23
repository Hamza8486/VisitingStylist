// ignore_for_file: must_be_immutable

import 'package:email_validator/email_validator.dart';
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


class ResetView extends StatelessWidget {
  ResetView({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

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
                      Get.put(AuthController()).clear();
                      Get.put(AuthController()).clearCompleteProfile();
                      Get.put(AuthController()).clearLogin();
                      Get.back();
                    }
                ),
                SizedBox(height: Get.height*0.04,),
                AppText(title: "Forget Password",
                  size: AppSizes.size_21,
                  fontFamily: AppFont.semi,
                  color: AppColor.boldBlackColor,
                ),
                SizedBox(height: Get.height*0.01,),
                AppText(title: "Enter your email ID associated with your account and we’ll send an verification code for reset your password",
                  size: AppSizes.size_12,
                  fontFamily: AppFont.regular,
                  textAlign: TextAlign.justify,
                  color: AppColor.textGreyColor,
                ),
                SizedBox(height: Get.height*0.025,),
                textAuth(text: "Email"),

                SizedBox(height: Get.height*0.012,),
                AppTextFied(

                  isborderline: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  isborderline2: true,
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Please enter a valid email",
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04,
                      vertical: Get.height * 0.0185),
                  borderRadius: BorderRadius.circular(10),
                  borderRadius2: BorderRadius.circular(10),
                  borderColor: AppColor.borderColorField,
                  hint: "Email",
                  hintColor: AppColor.blackColor,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  hintSize: AppSizes.size_12,
                  controller: authController.emailForgetController,
                  fontFamily: AppFont.medium,
                  borderColor2: AppColor.primaryColor,
                  maxLines: 1,
                ),

                SizedBox(height: Get.height*0.06,),



                Obx(
                  () {
                    return
                      authController.loaderForget.value?
                      const Center(
                          child: SpinKitThreeBounce(
                              size: 25, color: AppColor.primaryColor)
                      ):

                      AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: "Next", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap: (){




                      if (formKey.currentState!.validate()) {
                        authController.updateForgetLoader(true);
                        ApiManger().forgetResponse(context: context,email: authController.emailForgetController.text);


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
    );
  }
}
