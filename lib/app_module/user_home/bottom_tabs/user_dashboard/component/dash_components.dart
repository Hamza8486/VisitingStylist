import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';
import 'package:stylish_app/widgets/app_text.dart';


class CategoryListDashboard extends StatelessWidget {
  CategoryListDashboard({Key? key}) : super(key: key);
  final dashboardController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: Get.height * 0.05,
        child: Obx(
                () {
              return
                dashboardController.isCatLoading.value
                    ?
                GridView.builder(

                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 10),
                    itemCount: 3,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          color: AppColor.whiteColor,
                          elevation: 0.3,
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(10),

                          ),


                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,

                                  borderRadius: BorderRadius.circular(10)),
                              width: Get.width,

                            ),
                          ));
                    }):



                Obx(
                  () {
                    return ListView.builder(
                        itemCount:
                        dashboardController.catList.length + 1,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection:
                        dashboardController.catList.isNotEmpty?Axis.horizontal:
                        Axis.horizontal,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return index == 0
                              ? GestureDetector(
                            onTap: () {

                              print(index);


                              dashboardController.updateName("all");
                              dashboardController
                                  .updateDataHome("all");

                              dashboardController.updateCategoryIndex(index);
                              dashboardController.getServiceData(cat: null);
                            },
                            child: Obx(
                              () {
                                return Card(
                                  margin: EdgeInsets.only(
                                      left:
                                      index==0?0:
                                      Get.width * 0.01,right: Get.width * 0.01,
                                      top: 2,bottom: 2),
                                  color:dashboardController.categoryIndex.value == index?
                                       AppColor.primaryColor
                                      : AppColor.whiteColor,
                                  shape: RoundedRectangleBorder(   borderRadius: BorderRadius.circular(10),),
                                  shadowColor: AppColor.whiteColor,

                                  elevation: 2,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        Get.width * 0.06),
                                    child: Center(
                                      child: AppText(
                                        title: "All",
                                        color: dashboardController
                                            .categoryIndex
                                            .value ==
                                            index
                                            ? AppColor.whiteColor
                                            : AppColor.blackColor,
                                        size: AppSizes.size_13,
                                        fontFamily:dashboardController.catList.isEmpty ? AppFont.medium:AppFont.medium,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          )
                              :  GestureDetector(
                            onTap: () {
                              print(index);

                              dashboardController.updateName(dashboardController
                                  .catList[
                              index - 1]
                                  .name.toString());
                              dashboardController
                                  .updateDataHome("");

                              dashboardController
                                  .updateCategoryIndex(index);
                              dashboardController.getServiceData(cat:dashboardController
                                  .catList[
                              index - 1]
                                  .id.toString());

                            },
                            child: Obx(
                              () {
                                return Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                      Get.width * 0.01,vertical: 2),
                                  color: dashboardController
                                      .categoryIndex
                                      .value ==
                                      index
                                      ? AppColor.primaryColor
                                      : AppColor.whiteColor,
                                  shape: RoundedRectangleBorder(   borderRadius: BorderRadius.circular(10),),
                                  shadowColor: AppColor.whiteColor,


                                  elevation: 2,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        Get.width * 0.035),
                                    child: Center(
                                      child: AppText(
                                        title: dashboardController
                                            .catList[
                                        index - 1]
                                            .name.toString(),
                                        color: dashboardController
                                            .categoryIndex
                                            .value ==
                                            index
                                            ? AppColor.whiteColor
                                            : AppColor.blackColor,
                                        size: AppSizes.size_13,
                                        fontFamily: AppFont.medium,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          );

                        });
                  }
                );
            }
        ));
  }
}
