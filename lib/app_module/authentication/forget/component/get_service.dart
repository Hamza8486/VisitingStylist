import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/model/services_model.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/app_textfield.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);


  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {


    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    var size = Get.size;

    return DraggableScrollableSheet(
      initialChildSize: isKeyBoard ? 0.9 : 0.7,
      minChildSize: isKeyBoard ? 0.9 : 0.7,
      maxChildSize: isKeyBoard ? 0.9 : 0.7,
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
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    title: "Select Services",
                    size: AppSizes.size_15,
                    fontFamily: AppFont.semi,
                    fontWeight: FontWeight.w600,
                    color: AppColor.boldBlackColor,
                  ),
                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(child: Icon(Icons.cancel_outlined,size: Get.height*0.03,)))
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              AppTextFied(
                fillColor: AppColor.pinColor,
                isFill: true,
                onChange: (val) {
                  setState(() {
                    authController.getServiceData(search: val.toString(),
                    cat: "0"
                    );
                  });
                },
                isborderline: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                isborderline2: true,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
                borderRadius: BorderRadius.circular(10),
                borderRadius2: BorderRadius.circular(10),
                borderColor: AppColor.borderColorField,
                hint: "Search service",
                prefixIcon: Icon(
                  Icons.search
                ),
                isPrefix: true,
                hintColor: AppColor.boldBlackColor.withOpacity(0.5),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                hintSize: AppSizes.size_13,
                fontFamily: AppFont.semi,
                borderColor2: AppColor.primaryColor,
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: Obx(() {
                  return authController.isServiceLoading.value
                      ? Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.2,
                      ),
                      Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black26,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.primaryColor //<-- SEE HERE

                            ),
                          )),
                    ],
                  )
                      : ListView.builder(
                      itemCount: authController.serviceList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      primary: false,
                      itemBuilder:
                          (BuildContext context, int index) {

                        return Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                authController.toggleServiceSelection(authController.serviceList[index]);
                                authController.updateValue(authController.serviceList[index].id.toString());
                                authController.updateName(authController.serviceList[index].name.toString());
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Obx(() {
                                        return

                                          authController.selectIndex
                                              .contains(authController.serviceList[index].id.toString())?
                                          Icon(
                                            Icons.check_box,
                                            color: AppColor.primaryColor,
                                            size: Get.height * 0.03,
                                          ):
                                          Icon(
                                            Icons.check_box_outline_blank,
                                            color: AppColor.greyColor,
                                            size: Get.height * 0.03,
                                          );
                                      }),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          AppText(
                                            title: authController
                                                .serviceList[
                                            index]
                                                .name ??
                                                "",
                                            size: AppSizes
                                                .size_14,
                                            fontFamily:
                                            AppFont.medium,
                                            fontWeight:
                                            FontWeight.w400,
                                            color: AppColor
                                                .boldBlackColor,
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                          ],
                        );
                      });
                }),
              ),
             isKeyBoard?SizedBox.shrink():
             Column(
               children: [
                 SizedBox(
                   height: Get.height * 0.01,
                 ),
                 AppButton(
                     buttonWidth: Get.width,
                     buttonRadius: BorderRadius.circular(30),
                     buttonName: "Confirm",


                     fontWeight: FontWeight.w500,
                     textSize: AppSizes.size_14,
                     fontFamily: AppFont.medium,
                     buttonColor: AppColor.primaryColor,
                     textColor: AppColor.whiteColor,
                     onTap: () {
                       Get.back();

                     }),

                 SizedBox(
                   height: Get.height * 0.01,
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
