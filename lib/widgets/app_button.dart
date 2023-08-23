// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_text.dart';



class AppButton extends StatelessWidget {
  final String buttonName;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final FontWeight fontWeight;
  final BorderRadius buttonRadius;
  final IconData icon;
  final String iconImage;
  final bool isIcon;
  final bool isCenter;
  final double iconSize;
  final double paddingBtwn;
  final VoidCallback onTap;
  final double borderWidth;
  final Color borderColor;
  final String fontFamily;
  const AppButton({
    Key? key,
    required this.buttonName,
    this.buttonWidth = 150,
    this.buttonHeight = 53,
    required this.buttonColor,
    required this.textColor,
    this.fontWeight = FontWeight.w500,
    this.buttonRadius = BorderRadius.zero,
    this.iconColor = Colors.white,
    this.icon = Icons.home,
    this.iconImage = "",
    this.isIcon = false,
    this.isCenter = false,
    this.iconSize = 30,
    this.paddingBtwn = 0,
    this.fontFamily = "boldInter",
    required this.onTap,
    this.textSize = 15,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    // required Color textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
              borderRadius: buttonRadius,
              color: buttonColor,
              border: Border.all(
                width: borderWidth,
                color: borderColor,
              )),
          child: Padding(
            padding: isCenter
                ? const EdgeInsets.symmetric(horizontal: 20)
                : EdgeInsets.only(left: paddingBtwn == 0 ? 0 : 15),
            child: Row(
              mainAxisAlignment: paddingBtwn == 0
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isIcon
                    ? iconImage == ""
                    ? Icon(
                  icon,
                  color: iconColor,
                  size: iconSize,
                )
                    : Image.asset(
                  iconImage,
                  height: iconSize,
                )
                    : Container(),
                isCenter
                    ? const Spacer()
                    : SizedBox(
                  width: paddingBtwn == 0
                      ? isIcon
                      ? 10
                      : 0
                      : paddingBtwn,
                ),
                Center(
                  child: AppText(
                      title: buttonName,
                      color: textColor,
                      fontFamily: fontFamily,
                      fontWeight: fontWeight,
                      size: textSize),
                ),
                isCenter ? const Spacer() : Container(),
                isCenter
                    ? isIcon
                    ? iconImage == ""
                    ? Icon(
                  icon,
                  color: iconColor,
                  size: iconSize,
                )
                    : Image.asset(iconImage,
                    height: iconSize, color: Colors.transparent)
                    : Container()
                    : Container(),
              ],
            ),
          )),
    );
  }
}
Widget backButton({onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
       decoration: BoxDecoration(

         border: Border.all(color: AppColor.greyLightColor.withOpacity(0.5)),
         borderRadius: BorderRadius.circular(10),
       ),

        // color: color,
        child: Padding(
          padding: EdgeInsets.only(
              left: Get.width * 0.027,
              right: Get.width * 0.032,
              top: Get.height * 0.013,
              bottom: Get.height * 0.014),
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: AppColor.black,
            size: AppSizes.size_13,
          ),
        ),
      ));
}

Widget navBar({onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(

        decoration: BoxDecoration(boxShadow: [

        BoxShadow(
        color: AppColor.primaryColor.withOpacity(0.07),
        spreadRadius: 2,
        blurRadius: 3,
        offset: Offset(0, 3),

      ),
        ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),



        // color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
          child: SvgPicture.asset("assets/icons/nav.svg",height: Get.height*0.022,),
        ),
      ));
}