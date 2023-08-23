import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:stylish_app/app_module/authentication/login.dart';
import 'package:stylish_app/app_module/stylish_home/view/stylish_home.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/helper_function.dart';

import '../user_home/view/user_home.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String id = "";
  String userTypeS = "";
  String? _currentAddress;
  Position? _currentPosition;
  int selectedPageIndex = 0;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentPosition = position;
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.checkPermission();
        await Geolocator.requestPermission();
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        // return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();

    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {

    });
  }


  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {

        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }


  @override
  void initState() {
    super.initState();

    HelperFunctions.getFromPreference("userType").then((value) {
      setState(() {
        userTypeS = value;
      });

      print("Hamza");
      print(userTypeS.toString());
      moveToNext();
    });

  }

  void moveToNext() {

    Timer(const Duration(seconds:2), () {
      if (userTypeS == "client") {
        Get.offAll(
            UserHome(),
            transition: Transition.cupertinoDialog
        );
      }
      else if (userTypeS == "stylist") {

        Get.offAll(
             StylishHome(),
            transition: Transition.cupertinoDialog
        );
      }
      else {
        Get.offAll(
            LoginView(),
            transition: Transition.cupertinoDialog
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height*0.33,),

              Center(
                child: Image.asset("assets/images/main.png",
                  height: Get.height*0.33,
                ),
              )

            ],
          ),
        ));
  }
}
