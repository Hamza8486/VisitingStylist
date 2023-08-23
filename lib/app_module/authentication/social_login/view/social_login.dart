// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:stylish_app/app_module/authentication/auth_controller.dart';
import 'package:stylish_app/services/api_manager.dart';



class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoggin = false;

  var facebookLogin = FacebookAuth.i;

  Future facebookSignIn({required BuildContext context,token}) async {
    var data;
    // try {
    var _result = await facebookLogin.login(
      permissions: [
        'email',
        'public_profile',
      ],
    );
    log(_result.message.toString());

    switch (_result.status) {
      case LoginStatus.cancelled:
        Get.back();
        log("This is error ${_result.toString()}");
        log("This is error ${_result.message.toString()}");
        log("Canceled By User");
        break;

    case LoginStatus.operationInProgress:
      log("in progress");
      break;

      case LoginStatus.success:
        FacebookAuth.i.getUserData(
          fields: "name,email,picture.width(200)",
        );

        AuthCredential _credentials = FacebookAuthProvider.credential(
            _result.accessToken!.token.toString());

        var a = await FirebaseAuth.instance
            .signInWithCredential(_credentials)
            .catchError((e) {
          log(e.toString());
        });

        data = a;
        final String? email = a.user?.email.toString();
        final String? name = a.user?.displayName;
        final String gid = a.user!.uid;
        debugPrint("This is user facebook ${a.user?.email.toString()}");
        debugPrint("This is name ${a.user?.providerData[0].displayName}");
        debugPrint("This is email ${a.user?.providerData[0].email}");


        // final String ?pic=user.photoURL;

        debugPrint(name);
        debugPrint(email);
        // showLoading(context: context);
        // Get.put(NearbyController()).updateEmail(a.user?.providerData[0].email);
        // ApiManger().socialLoginResp(
        //     name: a.user?.providerData[0].displayName,
        //     email: a.user?.providerData[0].email,
        //     type: "facebook",
        //     context: context,token: token
        //
        //
        //
        //
        // );

        debugPrint("hhh $email");
        debugPrint(name);
        debugPrint(gid);

        //   // pr

        log(a.user!.displayName.toString());
        //  user =a.user;

        log("User id for fb " + a.user!.uid.toString());
        break;

      default:

      // userData = requestData;
      // log(jsonEncode(userData));

    }
    Get.back();
    log(_result.status.toString());
    log("This is status of error");

    // if (_auth.currentUser != null) {
    //   await _fireStore.collection("Users").doc(_auth.currentUser?.uid).set({
    //     "Name": data.user!.displayName.toString(),
    //     "Email": data.user!.email.toString(),
    //     "Password": "",
    //     "Image": "",
    //     "History": FieldValue.arrayUnion([]),
    //     "CreateQR": FieldValue.arrayUnion([]),
    //   });
    //   Get.offAll(LoginScreen());
    //
    // }

    return null;
    // } on FirebaseAuthException catch (e) {
    //   return e.message;
    // }
  }


  Future googlebySignIn({required BuildContext context, token}) async {
    var data;
    // try {
    googleSignIn.signOut().then((value) async {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final result = (await _auth.signInWithCredential(credential));
      User? user = result.user;
      final String? email = user?.providerData.first.email;
      final String? name = user?.displayName;
      final String? number = user?.phoneNumber;
      final String? photo = user?.photoURL;
      final String gid = user!.uid;


      Get.put(AuthController()).updateLoginLoader(true);
      ApiManger().socialLogins(
          name: name,
          email: email,
          type: "google",
          context: context,
          id: gid.toString(),
      token: token
      );

      debugPrint("hhh $email");
      debugPrint(name);
      debugPrint(gid);
      debugPrint(photo);
      debugPrint(number);
      ;
    });
    // } on FirebaseAuthException catch (e) {
    //   return e.message;
    // }
    return null;
  }

  // sha256ofString(String rawNonce) {}
  // Future appleSignIn({required BuildContext context, token}) async {
  //   var data;
  //   // try {
  //   final rawNonce = generateNonce();
  //   final nonce = sha256ofString(rawNonce);
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     // webAuthenticationOptions: WebAuthenticationOptions(
  //     //   clientId:
  //     //       "1041476040950-l8ot3cg3qeejrqbe8o98bain6ckuagqu.apps.googleusercontent.com",
  //     //   // redirectUri: Uri.parse(
  //     //   //   "https://youonline-chat-app.firebase.com/__/auth/handler",
  //     //   // ),
  //     // ),
  //     nonce: nonce,
  //   );
  //   var _map;
  //   final oauthCredential = OAuthProvider("apple.com").credential(
  //     idToken: appleCredential.identityToken,
  //     accessToken: appleCredential.authorizationCode,
  //   );
  //   UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  //   log(userCredential.toString());
  //   _map = {
  //     'first_name': userCredential.user?.providerData.first.displayName ??
  //         userCredential.user?.providerData.first.email?.split("@").first,
  //     'email': userCredential.user?.providerData.first.email,
  //   };
  //   print(_map);
  //
  //   showLoading(context: context);
  //   Get.put(NearbyController()).updateEmail(userCredential.user?.providerData.first.email);
  //
  //   ApiManger().socialLoginResp(
  //       name: userCredential.user?.providerData.first.displayName ??
  //           userCredential.user?.providerData.first.email?.split("@").first,
  //       email: userCredential.user?.providerData.first.email,
  //       type: "apple",
  //       context: context,
  //       token: token);
  //
  //   return null;
  // }
}
