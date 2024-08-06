import 'package:auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:network_service/network_service.dart';

class EmailPasswordController extends GetxController {
  bool isLoading = false;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  Future<void> loginWithEmailAndPassword() async {
    if(emailTextEditingController.text.isEmpty || passwordTextEditingController.text.isEmpty)return;
    isLoading = true;
    update();
    //this line of code is for the creating user OR Signing the users
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((val){
          isLoading=false;
          update();

    });
    //this line of code is for the logging the users who has already signedIn
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passwordTextEditingController.text)
        .then(
      (value) {
        isLoading = false;
        update();
        print(value.user!.email);
      },
    ).catchError((val) {
      isLoading = false;
      update();
    });
  }
}
