import 'package:flutter/material.dart';
import 'package:stylish_app/widgets/app_text.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';

class TestClass extends StatelessWidget {
  String data;
   TestClass({Key? key , required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(child: GestureDetector(
              onLongPress: (){
                Clipboard.setData(ClipboardData(
                    text: data));
              },
              child: AppText(title: data , color:Colors.black,)))),
    );
  }
}
