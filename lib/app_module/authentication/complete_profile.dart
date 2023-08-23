import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/app_module/authentication/component.dart';
import 'package:stylish_app/app_module/authentication/forget/component/get_service.dart';
import 'package:stylish_app/services/api_manager.dart';
import 'package:stylish_app/util/theme.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';
import 'package:stylish_app/widgets/bottom_sheet.dart';
import 'package:stylish_app/widgets/drop_down.dart';
import 'package:stylish_app/widgets/helper_function.dart';




class CompleteProfile extends StatefulWidget {
  CompleteProfile({Key? key,this.token}) : super(key: key);
  var token;

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final authController = Get.put(AuthController());

  List<String> genderTypes = [
    "Male",
    "Female",
    "Other",
  ];
  List<String> sitTypes = [
    "I work in a saloon",
    "I'm ready a mobile stylist on a self employed basis",
  ];
  String?gender;
  String?genderType;
  String?situations;
  String?sitType;
  void pickImage()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],

    ).then((value) {
      if(value!= null )
      {
        authController.fileCv = File(value.paths.first!
        );
        setState(() {

        });
      }
      return null;
    });
  }
  void pickImageIns()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],

    ).then((value) {
      if(value!= null )
      {
        authController.fileInsurance = File(value.paths.first!
        );
        setState(() {

        });
      }
      return null;
    });
  }
  void pickImageDb()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],

    ).then((value) {
      if(value!= null )
      {
        authController.fileDb = File(value.paths.first!
        );
        setState(() {

        });
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return   WillPopScope(
      onWillPop: () async =>

      false,
      child: Stack(
        children: [
          Scaffold(
              body: Padding(
                padding: AppPaddings.mainPadding,
                child: Column(
                  children: [
                    SizedBox(height: Get.height*0.035,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // backButton(
                        //     onTap: (){
                        //       Navigator.pop(context);
                        //       Navigator.pop(context);
                        //       Get.put(AuthController()).clear();
                        //       Get.put(AuthController()).clearCompleteProfile();
                        //       Get.put(AuthController()).clearLogin();
                        //     }
                        // ),
                        AppText(
                          title: "Complete Profile",
                          size: AppSizes.size_18,
                          fontFamily: AppFont.semi,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackDarkColor,
                        ),
                        // Container()
                      ],
                    ),
                    SizedBox(height: Get.height*0.01,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height: Get.height*0.02,),
                            textAuth(
                                text: "Select Gender", color: Colors.red),
                            SizedBox(
                              height: Get.height * 0.013,
                            ),
                          dropDownButtons(

                              contentPadding: EdgeInsets.only(
                                  top: Get.height * 0.016,
                                  bottom: Get.height * 0.016,
                                  right: 10),

                              hinText: "Select Gender",
                              value: gender,
                              items: genderTypes.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  gender=val;
                                  genderType=val=="Male"?"male":val=="Female"?"Female":"other";
                                });

                              }),

                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: "Which describes your current situation?",color: Colors.red,
                            height: AppSizes.size_14
                            ),
                            SizedBox(
                              height: Get.height * 0.008,
                            ),
                            dropDownButtons(

                                contentPadding: EdgeInsets.only(
                                    top: Get.height * 0.016,
                                    bottom: Get.height * 0.016,
                                    right: 10),

                                hinText: "Select current situation",
                                value: situations,
                                items: sitTypes.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    situations=val;
                                    sitType=val=="I work in a saloon"?"salon":"self";
                                  });

                                }),

                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: "How far are you able to travel from home?",color: Colors.red),
                            SizedBox(
                              height: Get.height * 0.008,
                            ),
                            stylishField(
                                hint: "Please enter miles",
                                isPrefix: true,
                                onChange: (val){
                                  if (val!.isNotEmpty && int.tryParse(val) != null) {
                                    int intValue = int.parse(val);
                                    if (intValue > 25) {
                                      setState(() {
                                        flutterToast(msg: "Miles must be less than or equal to 25");
                                        authController.travelController.clear();
                                      });
                                    } else {
                                      setState(() {

                                      });
                                    }
                                  }
                                },


                                controller: authController.travelController,
                                textInputType: TextInputType.phone,

                                isSuffix: false
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: "How did you hear about us?",color: Colors.transparent),
                            SizedBox(
                              height: Get.height * 0.008,
                            ),
                            stylishField(
                                hint: "Please enter where did you hear about us",
                                isPrefix: true,
                                controller: authController.hearController,

                                isSuffix: false
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: "Select Multiple Services",color: Colors.red),
                            SizedBox(
                              height: Get.height * 0.008,
                            ),
                            Obx(
                              () {
                                return stylishField(
                                  onTap: (){
                                    FocusScope.of(context).unfocus();
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        isDismissible: true,
                                        context: context,
                                        builder: (context) =>  AddService());
                                  },
                                    hint:
                                    authController.selectName.isEmpty?"Please select services":
                                    authController.selectName.join(", "),
                                    isPrefix: true,
                                    hintColor:authController.selectName.isEmpty?AppColor.greyColors:AppColor.boldBlackColor ,
                                    isRead: true,
                                    cur: false,

                                    child: Icon(Icons.arrow_drop_down,color: Colors.black.withOpacity(0.5),
                                    size: AppSizes.size_20,
                                    ),

                                    isSuffix: false
                                );
                              }
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: "Driving license or Passport",color: Colors.red),
                            SizedBox(
                              height: Get.height * 0.008,
                            ),
                            GestureDetector(
                              onTap: (){
                                if(authController.fileCnic==null){
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) => bottomSheet(onCamera: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.camera)
                                            .then((value) {
                                          setState(() {
                                            authController.fileCnic = value!;
                                          });
                                        });
                                      }, onGallery: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.gallery)
                                            .then((value) {
                                          setState(() {
                                            authController.fileCnic = value!;
                                          });
                                        });
                                      }));
                                }
                                else{
                                  setState(() {
                                    authController.fileCnic=null;
                                  });
                                }

                              },
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:  authController.fileCnic==null?
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                  child: AppText(
                                    title: "Choose File",
                                    size: AppSizes.size_12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppFont.regular,
                                    color: AppColor.blackDarkColor,
                                  ),
                                ):Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        title: "File Selected",
                                        size: AppSizes.size_13,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFont.medium,
                                        color: AppColor.blackDarkColor,
                                      ),
                                      SizedBox(width: Get.width*0.02,),
                                      Icon(Icons.cancel_outlined,color: Colors.red,
                                        size: Get.height*0.023,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    textAuth(text: "Insurance",color: Colors.transparent),
                                    SizedBox(
                                      height: Get.height * 0.008,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        if( authController.fileInsurance==null){
                                          pickImageIns();
                                        }
                                        else{
                                          setState(() {
                                            authController.fileInsurance=null;
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child:    Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                          child:
                                          authController.fileInsurance==null?
                                          AppText(
                                            title: "Choose File",
                                            size: AppSizes.size_12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppFont.regular,
                                            color: AppColor.blackDarkColor,
                                          ):Row(
                                            children: [
                                              AppText(
                                                title: "File Selected",
                                                size: AppSizes.size_13,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: AppFont.medium,
                                                color: AppColor.blackDarkColor,
                                              ),
                                              SizedBox(width: Get.width*0.02,),
                                              Icon(Icons.cancel_outlined,color: Colors.red,
                                                size: Get.height*0.023,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    textAuth(text: "DBS Certificate",color: Colors.transparent),
                                    SizedBox(
                                      height: Get.height * 0.008,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        if( authController.fileDb==null){
                                          pickImageDb();
                                        }
                                        else{
                                          setState(() {
                                            authController.fileDb=null;
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child:    Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                          child:
                                          authController.fileDb==null?
                                          AppText(
                                            title: "Choose File",
                                            size: AppSizes.size_12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppFont.regular,
                                            color: AppColor.blackDarkColor,
                                          ):Row(
                                            children: [
                                              AppText(
                                                title: "File Selected",
                                                size: AppSizes.size_13,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: AppFont.medium,
                                                color: AppColor.blackDarkColor,
                                              ),
                                              SizedBox(width: Get.width*0.02,),
                                              Icon(Icons.cancel_outlined,color: Colors.red,
                                                size: Get.height*0.023,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                           Row(
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(
                                     height: Get.height * 0.02,
                                   ),
                                   textAuth(text: "CV",color: Colors.transparent),
                                   SizedBox(
                                     height: Get.height * 0.008,
                                   ),
                                   GestureDetector(
                                     onTap: (){
                                       if( authController.fileCv==null){
                                         pickImage();
                                       }
                                       else{
                                         setState(() {
                                           authController.fileCv=null;
                                         });
                                       }
                                      },
                                     child: Container(
                                       decoration: BoxDecoration(
                                           color: Colors.grey.withOpacity(0.7),
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child:    Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                         child:
                                         authController.fileCv==null?
                                         AppText(
                                           title: "Choose File",
                                           size: AppSizes.size_12,
                                           fontWeight: FontWeight.w500,
                                           fontFamily: AppFont.regular,
                                           color: AppColor.blackDarkColor,
                                         ):Row(

                                           children: [
                                             AppText(
                                               title: "File Selected",
                                               size: AppSizes.size_13,
                                               fontWeight: FontWeight.w500,
                                               fontFamily: AppFont.medium,
                                               color: AppColor.blackDarkColor,
                                             ),
                                             SizedBox(width: Get.width*0.02,),
                                             Icon(Icons.cancel_outlined,color: Colors.red,
                                             size: Get.height*0.023,
                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                               Container()
                             ],
                           ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
]
                        ),
                      ),
                    ),
                    isKeyBoard?SizedBox.shrink():
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    isKeyBoard?SizedBox.shrink():
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(30),
                        buttonName: "Complete Profile Now",


                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_14,
                        fontFamily: AppFont.medium,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          print(widget.token);

                        if(validateRegister(context)){
                          authController.updateComplete(true);
                          ApiManger().createProfile(context: context,
                              token: widget.token,
                              gender: genderType.toString(),
                              situation: sitType.toString(),
                              far: authController.travelController.text,
                              hear: authController.hearController.text
                          );
                        }

                        }),
                    isKeyBoard?SizedBox.shrink():
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                  ],
                ),
              )
          ),
          Obx(() {
            return authController.completeProfile.value == false
                ? SizedBox.shrink()
                : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black26,
              child:  Center(
                  child: SpinKitThreeBounce(
                      size: 25, color: AppColor.black)
              ),
            );



          })
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> countryDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].accountType,
            size: AppSizes.size_15,
            color: AppColor.white.withOpacity(0.8),
            fontFamily: AppFont.regular,
            fontWeight: FontWeight.w500,
          )));
    }
    return outputList;
  }

  bool validateRegister(BuildContext context) {


    if (genderType==null) {
      flutterToast(msg: "Please select gender");
      return false;
    }
    if (situations==null) {
      flutterToast(msg: "Please tell about current situation");
      return false;
    }
    if (authController.travelController.text.isEmpty) {
      flutterToast(msg: "Please tell about how far");
      return false;
    }
    if (authController.hearController.text.isEmpty) {
      flutterToast(msg: "Please enter where did you hear about us");
      return false;
    }
    if (authController.selectIndex.isEmpty) {
      flutterToast(msg: "Please select services");
      return false;
    }
    // if (authController.fileCnic==null) {
    //   flutterToast(msg: "Please upload driving license or passport");
    //   return false;
    // }







    return true;
  }
}
