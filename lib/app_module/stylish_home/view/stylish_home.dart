import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/stylish_home/controller/stylish_controller.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_booking/view/my_booking.dart';
import 'package:stylish_app/app_module/stylish_home/tabs/stylish_profile/view/profile_view.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';




class StylishHome extends StatefulWidget {
  int currentIndex;

  StylishHome({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  _StylishHomeState createState() => _StylishHomeState();
}

class _StylishHomeState extends State<StylishHome> {
  final homeController = Get.put(StylishController());
  final List _screens = [
    StyLishBookings(),
    StylishProfile(),


  ];

  void _selectedPage(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: ()   => showExitPopups1(context, widget.currentIndex, (val) {
        setState(() {
          widget.currentIndex = val;
        });
      }),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedLabelStyle:
          TextStyle(fontFamily: AppFont.medium, fontSize: AppSizes.size_12,
              color: AppColor.primaryColor
          ),
          unselectedLabelStyle: TextStyle(
              color: AppColor.blackDarkColor,
              fontFamily: AppFont.medium,
              fontSize: AppSizes.size_12),
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.blackColor,
          onTap: _selectedPage,
          currentIndex: widget.currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                    left: 7, top: 7, bottom: 7, right: 7),
                child: SvgPicture.asset("assets/icons/home.svg",
                  height: Get.height * 0.025,
                  color: widget.currentIndex == 0
                      ? AppColor.primaryColor
                      : AppColor.blackDarkColor,
                ),

              ),
              label: "Home",
              tooltip: "Home",
            ),


            BottomNavigationBarItem(
              icon: Padding(
                padding:  const EdgeInsets.only(
                    left: 7, top: 7, bottom: 7, right: 7),
                child: SvgPicture.asset("assets/icons/profile.svg",
                  height: Get.height * 0.025,
                  color: widget.currentIndex == 1
                      ? AppColor.primaryColor
                      : AppColor.blackDarkColor,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
        body: _screens[widget.currentIndex],

      ),
    );
  }
}
