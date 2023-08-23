import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/bottom_sheet.dart';

class CancelStylishWidget extends StatefulWidget {
   CancelStylishWidget({Key? key,this.id}) : super(key: key);
  var id;


  @override
  State<CancelStylishWidget> createState() => _CancelStylishWidgetState();
}

class _CancelStylishWidgetState extends State<CancelStylishWidget> {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {


    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    var size = Get.size;

    return DraggableScrollableSheet(
      initialChildSize:  0.4,
      minChildSize:  0.4,
      maxChildSize: 0.4,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Image.asset("assets/images/line.png",
                  height: Get.height*0.006,
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  AppText(
                    title: "Cancel booking?",
                    size: AppSizes.size_18,
                    fontFamily: AppFont.semi,
                    fontWeight: FontWeight.w600,
                    color: AppColor.redColor,
                  ),

                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Divider(color: AppColor.greyLightColor,),
              SizedBox(
                height: Get.height * 0.01,
              ),
              AppText(
                title: "Are you sure you want to cancel your client Booking?",
                size: AppSizes.size_17,
                fontFamily: AppFont.semi,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                color: AppColor.boldBlackColor,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              AppText(
                title: "There is a 10% charge applied to booking cancelled within 12 hours of appointment time",
                size: AppSizes.size_13,
                fontFamily: AppFont.regular,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                color: AppColor.greyLightColor,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primaryColor),
                            borderRadius: BorderRadius.circular(30),
                          color: AppColor.primLightColor
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 13),
                          child: Center(
                            child: AppText(
                              title: "cancel",
                              size: AppSizes.size_14,
                              overFlow: TextOverflow.ellipsis,
                              maxLines: 1,
                              fontFamily: AppFont.semi,
                              fontWeight: FontWeight.w500,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width*0.03,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                        showLoading1(context: context);
                        ApiManger().cancelStylishBooking(id:widget.id.toString() );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primaryColor),
                            borderRadius: BorderRadius.circular(30),
                          color: AppColor.primaryColor
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 13),
                          child: Center(
                            child: AppText(
                              title: "Yes, cancel booking",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}







class RejectBootmSheet extends StatefulWidget {
   RejectBootmSheet({Key? key,this.id,this.text,this.text1,this.text2}) : super(key: key);
  var id;
  var text;
  var text1;
  var text2;

  @override
  State<RejectBootmSheet> createState() => _RejectBootmSheetState();
}

class _RejectBootmSheetState extends State<RejectBootmSheet> {
  @override
  Widget build(BuildContext context) {

    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    var size = Get.size;
    return DraggableScrollableSheet(
      initialChildSize:  0.33,
      minChildSize:  0.33,
      maxChildSize: 0.33,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Image.asset("assets/images/line.png",
                  height: Get.height*0.006,
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  AppText(
                    title: "${widget.text} booking?",
                    size: AppSizes.size_18,
                    fontFamily: AppFont.semi,
                    fontWeight: FontWeight.w600,
                    color: AppColor.redColor,
                  ),

                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Divider(color: AppColor.greyLightColor,),
              SizedBox(
                height: Get.height * 0.01,
              ),
              AppText(
                title: "Are you sure you want to ${widget.text1} your client Booking?",
                size: AppSizes.size_16,
                fontFamily: AppFont.semi,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                color: AppColor.boldBlackColor,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primaryColor),
                            borderRadius: BorderRadius.circular(30),
                            color: AppColor.primLightColor
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 13),
                          child: Center(
                            child: AppText(
                              title: "cancel",
                              size: AppSizes.size_14,
                              overFlow: TextOverflow.ellipsis,
                              maxLines: 1,
                              fontFamily: AppFont.semi,
                              fontWeight: FontWeight.w500,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width*0.03,),
                  Expanded(
                    child: GestureDetector(
                      onTap:
                    widget.text=="Reject"?

                          (){
                        Get.back();
                        showLoading1(context: context);
                        print(widget.id.toString());
                        ApiManger().rejectBooking(id:widget.id.toString() );
                      }:

                    widget.text=="Complete"?

                        (){
                      Get.back();
                      showLoading1(context: context);
                      print(widget.id.toString());
                      ApiManger().completeBooking(id:widget.id.toString() );
                    }:
                        (){
                      Get.back();
                      showLoading1(context: context);
                      ApiManger().acceptBooking(id:widget.id.toString() );
                    },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primaryColor),
                            borderRadius: BorderRadius.circular(30),
                            color: AppColor.primaryColor
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 13),
                          child: Center(
                            child: AppText(
                              title:
                              widget.text=="Complete"? "Yes, ${widget.text2} Now":
                              "Yes, ${widget.text2} booking",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

