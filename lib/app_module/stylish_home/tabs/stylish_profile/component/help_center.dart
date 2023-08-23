
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/helper_function.dart';

import 'package:webview_flutter/webview_flutter.dart';



class StylishHelpCenter extends StatefulWidget {
  const StylishHelpCenter({Key? key}) : super(key: key);

  @override
  State<StylishHelpCenter> createState() => _StylishHelpCenterState();
}

class _StylishHelpCenterState extends State<StylishHelpCenter> {

  bool isLoading=true;
  final _key = UniqueKey();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04, vertical: Get.height * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(
              children: [
                backButton(

                    onTap: () {
                      Get.back();
                    }),
                SizedBox(
                  width: Get.width * 0.23,
                ),
                AppText(
                  title: "Help Center",
                  color: AppColor.blackColor,
                  size: AppSizes.size_18,
                  fontFamily: AppFont.semi,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Expanded(
              child: Stack(
                children: [
                  WebView(
                    initialUrl: 'https://visitingstylist.fgn.lcg.mybluehost.me/contact',
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  isLoading ? Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.white,
                      child: loader())
                      : Stack(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
