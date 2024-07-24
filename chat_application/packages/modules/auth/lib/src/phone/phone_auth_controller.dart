import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:network_service/network_service.dart';

class PhoneAuthController extends GetxController {

  String smsCode = "";

  TextEditingController phoneNumberTextEditingController=TextEditingController();
  TextEditingController otpTextEditingController=TextEditingController();
  void sendOtp({required String phoneNumber}) async {
    FirebaseAuth auth = FirebaseAuth.instance;


    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        log("verificationCompleted");
        await auth.signInWithCredential(credential).then((value) {
          print(value.user!.phoneNumber);
          // value.additionalUserInfo;
          // value.credential;
          // value.user.phoneNumber;
        },);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        this.verificationId = verificationId;

        // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: "000000");
        //
        // // Sign the user in (or link) with the credential
        // print((await auth.signInWithCredential(credential)).user!.phoneNumber);
        log("codeSent");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("codeAutoRetrievalTimeout");
      },
    );
  }

  String verificationId="";
  verify(String sms)async{
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode:sms );
    await auth.signInWithCredential(credential).then((value) {
      log("BRO DONE 11111111");
      log(value.user!.phoneNumber.toString());
      // value.additionalUserInfo;
      // value.credential;
      // value.user.phoneNumber;
    },);
  }

}
