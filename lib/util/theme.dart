import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  static const primaryColor = Color(0xffDCAA53);
  static const blackDarkColor = Color(0xff242424);
  static const greyLightColor = Color(0xff909090);
  static const strokeColor = Color(0xffC4C4C4);
  static const primLightColor = Color(0xffFDF4E7);
  static const socialColor = Color(0xffEAEFF3);
  static const backColor = Color(0xffE8E6EA);
  static const redColor = Color(0xffEA4335);


  static const borderColorField = Color(0xFFE8E6EA);
  static Color tabsColor = const Color(0xffF7F7F7);
  static Color greyColors = const Color(0xff808080);

  static const whiteColor = Colors.white;
  static const lightAppColor2 = Color(0xFFBAD3FC);
  static const redLight = Color(0xFFFFDEE2);
  static Color get primaryColor1 => const Color(0xff92A3FD);
  static Color get primaryColor2 => const Color(0xff9DCEFF);

  static Color get secondaryColor1 => const Color(0xffC58BF2);
  static Color get secondaryColor2 => const Color(0xffEEA4CE);


  static List<Color> get primaryG => [ primaryColor2, primaryColor1 ];
  static List<Color> get secondaryG => [secondaryColor2, secondaryColor1];

  static Color get black => const Color(0xff1D1617);
  static Color get gray => const Color(0xff786F72);
  static Color get white => Colors.white;
  static Color get lightGray => const Color(0xffF7F8F8);
  static const lightRed = Color(0xFFFFCDCC);
  static const boxAppColor = Color(0xFFBAD3FC);
  static const blackColor = Color(0xFF000000);
  static const tabColor = Color(0xFF9DB2CE);
  static Color catBorderColors = const Color(0xffD8D1D1);
  static const boldBlackColor = Color(0xFF212121);
  static const headColor = Color(0xFFF0F0F0);
  static const pinColor = Color(0xFFF8F8FC);
  static const textGreyColor = Color(0xFF9099A8);
  static const boldGreyColor = Color(0xFF9A9A9A);
  static const greyColor = Colors.grey;
  static Color catColor = const Color(0xffF9F9FD);
  static const backgroundColor = Color.fromARGB(255, 243, 243, 243);
  static const transParent = Colors.transparent;

  static Color Color1 =  const Color(0xffDBFDDF);
  static Color Color2 =  const Color(0xff6BAE00);
  static Color Color3 =  const Color(0xffFFE6F3);
  static Color Color4 =  const Color(0xffFDF4DB);
  static Color Color5 =  const Color(0xffFFE8E0);
  static Color Color6 =  const Color(0xffF2E1FF);
  static Color Color7 =  const Color(0xffE1F4FF);
  static Color Color8 =  const Color(0xffFFDFDF);



}

class AppSizes {
  static double size_10 = Get.height / 81.2;
  static double size_11 = Get.height / 73.8;
  static double size_12 = Get.height / 67.7;
  static double size_13 = Get.height / 62.5;
  static double size_14 = Get.height / 58;
  static double size_15 = Get.height / 54.1;
  static double size_16 = Get.height / 50.8;
  static double size_17 = Get.height / 47.8;
  static double size_18 = Get.height / 45.1;
  static double size_19 = Get.height / 42.7;
  static double size_20 = Get.height / 40.6;
  static double size_21 = Get.height / 38.7;
  static double size_22 = Get.height / 36.9;
  static double size_23 = Get.height / 35.3;
  static double size_24 = Get.height / 33.8;
  static double size_25 = Get.height / 32.5;
  static double size_26 = Get.height / 31.2;
  static double size_27 = Get.height / 30.1;
  static double size_28 = Get.height / 29;
  static double size_29 = Get.height / 28;
  static double size_30 = Get.height / 27.1;
}




class AppPaddings {
  static EdgeInsets mainPadding = EdgeInsets.only(
      right: Get.width * 0.04,left: Get.width * 0.04, top: Get.height * 0.03,);


  static EdgeInsets mainHomePadding = EdgeInsets.only(
      left: Get.width * 0.04,right: Get.width * 0.04, top: Get.height * 0.045);
  static EdgeInsets mainHorizontal = EdgeInsets.symmetric(
      horizontal: Get.width * 0.04);
  static EdgeInsets mainVertical = EdgeInsets.symmetric(
      vertical: Get.height * 0.025);
}

void showLoadingIndicator({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          height: 65,width: 65,

          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),     color: Colors.white,),
          child: Container(

            height: 25,width: 25,color: Colors.transparent,child:  const Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.black26,
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColor.primaryColor //<-- SEE HERE

              ),
                // strokeWidth: 5,
          ),
            ),),
        ),
      );
    },
  );
}
class AppFont {
  static String regular = "regular";
  static String medium = "medium";
  static String bold = "bold";
  static String semi = "semi";
  static String light = "light";

}