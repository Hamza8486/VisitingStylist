import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/component.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';




class ReviewSheet extends StatefulWidget {
  ReviewSheet({Key? key,this.data}) : super(key: key);
  var data;

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  var homeController = Get.put(UserController());

  var rate = 0.0 ;

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    var size = Get.size;
    return DraggableScrollableSheet(
      initialChildSize:
      isKeyBoard? 0.77:
      0.47,
      minChildSize:  isKeyBoard? 0.77:
      0.47,
      maxChildSize:  isKeyBoard? 0.77:
      0.47,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01, horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),

                      Center(
                        child: AppText(
                            title: "Give Rating",
                            color: AppColor.blackColor,
                            fontFamily: AppFont.semi,
                            size: AppSizes.size_17),
                      ),

                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                          child: RatingBar.builder(
                            initialRating: rate,
                            itemSize: 35,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                            EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                rate = rating;
                                print(rate);
                              });



                            },
                          ),
                        ),
                      ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          textAuth(text: "Comment", color: Colors.transparent),
          SizedBox(
            height: Get.height * 0.01,
          ),
          stylishField(
              hint: "Write comment",
              isPrefix: true,
              max: 3,
              controller: commentController,

              isSuffix: true,
              textInputAction: TextInputAction.done),
          SizedBox(
            height: Get.height * 0.01),

                    ],
                  ),
                ),
              ),
              Obx(
                      () {
                    return
                      Get.put(UserController()).isRating.value?
                      Center(
                          child: SpinKitThreeBounce(
                              size: 25, color: AppColor.primaryColor)
                      ):


                      AppButton(buttonName: "Submit Rating", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor,
                        fontFamily: AppFont.semi,

                        onTap:  ()async{
                          if(validateRating(context)){
                            homeController.updateIsRating(true);
                            ApiManger().ratingData(context: context,id: widget.data.id.toString(),rating:rate.toStringAsFixed(0),
                            comment: commentController.text

                            );
                          }




                        },
                        buttonRadius: BorderRadius.circular(10),
                        buttonWidth: Get.width,
                      );
                  }
              ),

              SizedBox(
                  height: Get.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  bool validateRating(BuildContext context) {
    if (rate == 0.0) {
      flutterToast(msg: "Please give rating to stylist");
      return false;
    }






    return true;
  }
}


