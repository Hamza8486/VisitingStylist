import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/booking/view/my_booking.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/profile/view/profile_view.dart';
import 'package:stylish_app/app_module/user_home/bottom_tabs/user_dashboard/view/user_dashboard.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/util/toast.dart';




class UserHome extends StatefulWidget {
  int currentIndex;

  UserHome({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final homeController = Get.put(UserController());
  final List _screens = [
    UserDashboard(),
    MyBookings(),
    ProfileView(),

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
      onWillPop: ()   => showExitPopups(context, widget.currentIndex, (val) {
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
                padding: const EdgeInsets.only(
                    left: 7, top: 7, bottom: 7, right: 7),
                child: Image.asset(
                  "assets/icons/date.png",
                  height: Get.height * 0.025,
                  color: widget.currentIndex == 1
                      ? AppColor.primaryColor
                      : AppColor.blackDarkColor,
                ),
              ),
              label: "Booking",
              tooltip: "Booking",
            ),

            BottomNavigationBarItem(
              icon: Padding(
                padding:  EdgeInsets.only(
                    left: 7, top: 7, bottom: 7, right: 7),
                child: SvgPicture.asset("assets/icons/profile.svg",
                  height: Get.height * 0.025,
                  color: widget.currentIndex == 2
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
