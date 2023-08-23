import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, this.id,this.token,this.email,this.type}) : super(key: key);
  var id;
  var token;
  var email;
  var type;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  String currentText = "";
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    startTimer();
  }

  bool isEnabled = false;

  Timer? _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            debugPrint(_start.toString());
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            if (_start == 0) {
              debugPrint(_start.toString());
              timer.cancel();
              isEnabled = true;
            }
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: AppPaddings.mainHomePadding,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .015,
                ),
                backButton(
                    onTap: (){
                      Get.back();
                    }
                ),

                SizedBox(height: Get.height*0.03,),
                AppText(
                  title: 'Verify your\nEmail Address',
                  size: AppSizes.size_21,
                  fontWeight: FontWeight.w700,
                  color: AppColor.boldBlackColor,
                  fontFamily: AppFont.semi,
                ),
                SizedBox(
                  height: size.height * .005,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: "Check your SMS messages. we've sent you",
                        size: AppSizes.size_13,
                        color: AppColor.greyColor,
                        fontFamily: AppFont.medium,
                      ),
                      Row(
                        children: [
                          AppText(
                            title: "the Pin at ",
                            size: AppSizes.size_13,
                            color: AppColor.boldBlackColor,
                            fontFamily: AppFont.medium,
                          ),
                          AppText(
                            title:widget.email.toString(),
                            size: AppSizes.size_13,
                            color: Colors.grey,
                            fontFamily: AppFont.medium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 5) {
                        return "Please enter valid otp";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      fieldHeight: Get.height * 0.056,
                      fieldWidth: Get.height * 0.056,
                      shape: PinCodeFieldShape.box,
                      borderWidth: 1,
                      activeColor: AppColor.primaryColor,
                      inactiveColor: AppColor.greyColor,
                      inactiveFillColor: AppColor.whiteColor,
                      activeFillColor: AppColor.whiteColor,
                      selectedFillColor: AppColor.whiteColor,
                      selectedColor: AppColor.primaryColor,
                      disabledColor: AppColor.blackColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    cursorColor: AppColor.primaryColor,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    autoDisposeControllers: false,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),

                isEnabled
                    ? Obx(
                      () {
                        return
                          Get.put(AuthController()).resend.value == true?
                          Center(
                              child: SpinKitThreeBounce(
                                  size: 20, color: AppColor.primaryColor)
                          ):
                          InkWell(
                        onTap: () {
                          Get.put(AuthController()).updateResendOtp(true);
                          ApiManger.resendResponse(
                            context: context,
                            apiName:
                            widget.type=="forget"?"forgotPassword/resendCode":
                            "resendCode",
                            id: widget.id.toString(),
                            token: widget.token.toString()
                          ).then((value) {
                            if (value != null) {
                              setState(() {

                                _start = 60;
                                startTimer();
                                isEnabled = false;
                              });
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              title: "Didn’t receive code? ",
                              size: AppSizes.size_13,
                              fontFamily: AppFont.medium,
                              textAlign: TextAlign.justify,
                              color: AppColor.boldBlackColor,
                            ),
                            AppText(
                              title: "Resend OTP",
                              size: AppSizes.size_13,
                              fontFamily: AppFont.semi,
                              textAlign: TextAlign.justify,
                              color: AppColor.primaryColor,
                            ),
                          ],
                        ));
                      }
                    )
                    :
                          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        AppText(
                          title: "Resend Code in ",
                          size: AppSizes.size_13,
                          fontFamily: AppFont.medium,
                          textAlign: TextAlign.justify,
                          color: AppColor.boldBlackColor,
                        ),
                        AppText(
                          title: "${_start}s",
                          size: AppSizes.size_12,
                          fontFamily: AppFont.semi,
                          textAlign: TextAlign.justify,
                          color: AppColor.primaryColor,
                        ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(
                  () {
                    return
                      Get.put(AuthController()).otp.value == false?

                      AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: "Verify Otp",
                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_15,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap:

                            ()

                        {
                          if (formKey.currentState!.validate()) {
                            if(currentText.length==6) {
                                Get.put(AuthController()).updateOtp(true);
                                ApiManger().otpResponse(context: context,id: widget.id.toString(),
                                    otp: textEditingController.text,
                        apiNames:  widget.type=="forget"?"forgotPassword/verifyCode":
                        "verifyCode",
                        typeName:
                        widget.type=="forget"?
                        "forget":widget.type.toString(),
                        fieldName: widget.type=="forget"?"forgot_password_code":
                        "verification_code",
                        token: widget.token.toString()
                                );
                              }
                            }
                            else{
                              flutterToast(msg: "Please enter valid otp");
                            }

                          }


                    ):
                      Center(
                          child: SpinKitThreeBounce(
                              size: 20, color: AppColor.primaryColor)
                      )
                    ;
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
