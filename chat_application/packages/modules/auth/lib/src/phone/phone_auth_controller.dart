import 'dart:developer';

import 'package:auth/src/on_success/on_success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_storage/get_storage/get_storage.dart';
import 'package:network_service/network_service.dart';

class PhoneAuthController extends GetxController {
  String smsCode = "";
  bool isLoading = false;
  bool isOtpSend=false;

  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController otpTextEditingController = TextEditingController();

  void sendOtp({required String phoneNumber}) async {
    isLoading = true;
    update();
    FirebaseAuth auth = FirebaseAuth.instance;

    await FirebaseAuth.instance
        .verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        log("verificationCompleted");
        await auth.signInWithCredential(credential).then(
          (value) {
            print(value.user!.phoneNumber);
            // value.additionalUserInfo;
            // value.credential;
            // value.user.phoneNumber;
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;
        log("codeSent");
        isOtpSend=true;
        isLoading = false;
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("codeAutoRetrievalTimeout");
      },
    )
        .catchError((val) {
      isLoading = false;
      update();
    });
  }

  String verificationId = "";

  verify(String sms) async {
    isLoading=true;
    update();
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: sms);
    await auth.signInWithCredential(credential).then(
      (value) {
        isLoading=false;
        update();
        log("BRO DONE 11111111");
        log(value.user!.phoneNumber.toString());
        AppLocalStorage().setLoginStatus(isLoggedIn: true);
        OnAuthSuccess().createDb();
      },
    );
  }
}
