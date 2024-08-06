import 'package:auth/auth.dart';
import 'package:auth/src/on_success/on_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

class GoogleAuthController extends GetxController {
  final TextEditingController _phoneController = TextEditingController();

  Future<void> loginWithGoogle() async {
    return await FirebaseAuth.instance
        .signInWithProvider(GoogleAuthProvider())
        .then(
      (value) {
        print(value);
        openBottomSheetToEnterPhoneNumber();
      },
    );
  }

  void openBottomSheetToEnterPhoneNumber() {
    Get.bottomSheet(
        Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              child: Column(
                children: [
                  CupertinoTextFormFieldRow(
                    controller: _phoneController,
                    style: const TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                    placeholder: "Phone Number",
                    keyboardType: TextInputType.phone,
                    placeholderStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: CupertinoColors.placeholderText),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      OnAuthSuccess().createDb(phoneNumber: _phoneController.text);
                    },
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ));
  }

  void _addPhoneNumberToDataBase() async {}
}
