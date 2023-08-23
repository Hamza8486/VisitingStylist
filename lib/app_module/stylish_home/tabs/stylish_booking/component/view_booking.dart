import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_booking/component/component.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_button.dart';
import 'package:stylish_app/widgets/app_text.dart';

class ViewBooking extends StatelessWidget {
   ViewBooking({Key? key,this.data,this.type}) : super(key: key);
  var data;
  var type;

  @override
  Widget build(BuildContext context) {
    DateTime date =
    DateTime.parse(data.booking.date);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            Row(
              children: [
                backButton(

                    onTap: () {
                      Get.back();
                    }),
                SizedBox(
                  width: Get.width * 0.16,
                ),
                AppText(
                  title: "Booking Detail",
                  color: AppColor.blackColor,
                  size: AppSizes.size_18,
                  fontFamily: AppFont.semi,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        AppText(
                          title: "Date",
                          size: AppSizes.size_14,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackDarkColor,
                        ),
                        SizedBox(height: Get.height*0.01,),


                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.primLightColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.primaryColor,width: 1.2)
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                            child: AppText(
                              title: "${DateFormat('dd MMM yyyy').format(date)} ",
                              size: AppSizes.size_13,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackDarkColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: Get.width*0.04,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        AppText(
                          title: "Start Time",
                          size: AppSizes.size_14,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackDarkColor,
                        ),
                        SizedBox(height: Get.height*0.01,),


                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.primLightColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.primaryColor,width: 1.2)
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                            child: AppText(
                              title:DateFormat.jm().format(DateFormat("hh:mm").parse(data.booking.start)),
                              size: AppSizes.size_13,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackDarkColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: Get.width*0.05,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        AppText(
                          title: "End Time",
                          size: AppSizes.size_14,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackDarkColor,
                        ),
                        SizedBox(height: Get.height*0.01,),


                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.primLightColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.primaryColor,width: 1.2)
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                            child: AppText(
                              title:DateFormat.jm().format(DateFormat("hh:mm").parse(data.booking.end)),
                              size: AppSizes.size_13,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackDarkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                AppText(
                title: "Booking Address",
                size: AppSizes.size_14,
                fontFamily: AppFont.medium,
                fontWeight: FontWeight.w500,
                color: AppColor.blackDarkColor,
              ),
              SizedBox(height: Get.height*0.01,),


              Container(
                decoration: BoxDecoration(
                    color: AppColor.primLightColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.primaryColor,width: 1.2)
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                  child: AppText(
                    title: data.booking.address,
                    size: AppSizes.size_13,
                    fontFamily: AppFont.medium,
                    fontWeight: FontWeight.w600,
                    color: AppColor.blackDarkColor,
                  ),
                ),
              ),
                data.booking.description==null?SizedBox.shrink():
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),

                    AppText(
                      title: "Description",
                      size: AppSizes.size_14,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackDarkColor,
                    ),
                    SizedBox(height: Get.height*0.01,),


                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.primLightColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.primaryColor,width: 1.2)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                        child: AppText(
                          title: data.booking.description.toString(),
                          size: AppSizes.size_13,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackDarkColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          AppText(
                            title: "Total",
                            size: AppSizes.size_14,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackDarkColor,
                          ),
                          SizedBox(height: Get.height*0.01,),


                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColor.primLightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.primaryColor,width: 1.2)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                              child: AppText(
                                title:"£${data.booking.total.toString()}",
                                size: AppSizes.size_13,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackDarkColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: Get.width*0.05,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          AppText(
                            title: "Status",
                            size: AppSizes.size_14,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackDarkColor,
                          ),
                          SizedBox(height: Get.height*0.01,),


                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColor.primLightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.primaryColor,width: 1.2)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                              child: AppText(
                                title:data.booking.status.toString(),
                                size: AppSizes.size_13,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackDarkColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                AppText(
                  title: "Booking services :",
                  size: AppSizes.size_14,
                  fontFamily: AppFont.medium,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackDarkColor,
                ),

                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount:data.booking.services.length,
                    itemBuilder: (BuildContext context, int i) {

                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: Get.height*0.008),
                        child: Row(
                          children: [
                          Container(
                            height:8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: AppColor.boldBlackColor,
                              shape: BoxShape.circle
                            ),
                          )
                            ,
                            SizedBox(width: Get.width*0.03,),
                            AppText(
                              title:"${data.booking.services[i].name.toString()} (£${data.booking.services[i].price.toString()})",
                              size: AppSizes.size_15,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Divider(color: AppColor.greyLightColor,),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                AppText(
                  title: "Client Details :",
                  size: AppSizes.size_17,
                  fontFamily: AppFont.medium,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackDarkColor,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          AppText(
                            title: "Name",
                            size: AppSizes.size_14,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackDarkColor,
                          ),
                          SizedBox(height: Get.height*0.01,),


                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColor.primLightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.primaryColor,width: 1.2)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                              child: AppText(
                                title:"${data.booking.client.firstName.toString()} ${data.booking.client.lastName.toString()}",
                                size: AppSizes.size_13,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackDarkColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    data.booking.client.phone==null?Container():
                    SizedBox(width: Get.width*0.05,),
                    data.booking.client.phone==null?Container():
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          AppText(
                            title: "Phone",
                            size: AppSizes.size_14,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackDarkColor,
                          ),
                          SizedBox(height: Get.height*0.01,),


                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColor.primLightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.primaryColor,width: 1.2)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                              child: AppText(
                                title:data.booking.client.phone.toString(),
                                size: AppSizes.size_13,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackDarkColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

            ],)),
            SizedBox(
              height: Get.height * 0.01,
            ),
            GestureDetector(
              onTap: (){
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    isDismissible: true,
                    context: context,
                    builder: (context) =>  RejectBootmSheet(id: data.id.toString(),
                      text: "Accept",
                      text1: "Accept",
                      text2: "accept",
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryColor),
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(30)
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                  child: Center(
                    child: AppText(
                      title: "Accept booking",
                      size: AppSizes.size_13,
                      overFlow: TextOverflow.ellipsis,
                      maxLines: 1,
                      fontFamily: AppFont.semi,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
