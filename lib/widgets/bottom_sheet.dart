


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';


Widget bottomSheet({onCamera ,onGallery}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.25,
    minChildSize: 0.25,
    maxChildSize: 0.25,
    builder: (_, controller) => Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                InkWell(
                    onTap: onGallery,
                    child: iconCreation(
                        Icons.insert_photo, AppColor.primaryColor, "Gallery")),
                SizedBox(width: Get.width*0.2,),
                InkWell(
                    onTap: onCamera,
                    child: iconCreation(
                        Icons.camera_alt,AppColor.primaryColor , "Camera")),
              ],
            ),
          ],
        ),
      ),
    ),
  );


}

Widget iconCreation(IconData icons, Color color, String text) {
  return Column(
    children: [
      CircleAvatar(
        radius: 24,
        backgroundColor: color,
        child: Icon(
          icons,
          // semanticLabel: "Help",
          size: 22,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      AppText(
          title: text,
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w500,
          size: 15)
    ],
  );
}
getShimmerAllLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
          height: Get.height * 0.11,
          width: Get.width,

        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [

              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 18.0,
                color: Colors.white,
              ),

            ],
          ),
        )
      ],
    ),
  );
}

showAlertDialog(
    {required BuildContext context,
      required String text,
      required VoidCallback yesOnTap,
      bool isBoth = true}) {
  // set up the buttons
  Widget cancelButton = AppButton(
      buttonName: "Yes",
      buttonWidth: 100,
      buttonHeight: 40,
      buttonRadius: BorderRadius.circular(10),
      buttonColor: AppColor.primaryColor,
      textColor: Colors.white,
      onTap: yesOnTap);
  Widget continueButton = AppButton(
      buttonName: "No",
      buttonWidth: 100,
      buttonHeight: 40,
      buttonRadius: BorderRadius.circular(10),
      buttonColor: Colors.transparent,
      textColor: AppColor.black,
      borderColor: AppColor.primaryColor,
      onTap: () {
        Get.back();
      });
  AlertDialog alert = AlertDialog(
    content: Text(text,style: TextStyle(color: AppColor.black,fontFamily: AppFont.medium),),
    actions: [
      cancelButton,
      isBoth ? continueButton : Container(),
    ],
    actionsPadding: EdgeInsets.only(bottom: 10,right: 10,left: 10),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showLoading({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(

          height: 40,width: 40,color: Colors.transparent,child:   const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(
                AppColor.primaryColor //<-- SEE HERE

            ),
            // strokeWidth: 5,
          ),
        ),),
      );
    },
  );
}

void showLoading1({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(

          height: 40,width: 40,color: Colors.transparent,child:   Center(
            child:
            SpinKitThreeBounce(size: 25, color: AppColor.black))),
      );
    },
  );
}