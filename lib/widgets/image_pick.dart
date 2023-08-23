import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_text.dart';



Widget bottomSheet({onCamera ,onGallery}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.27,
    minChildSize: 0.27,
    maxChildSize: 0.27,
    builder: (_, controller) => Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.only(
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