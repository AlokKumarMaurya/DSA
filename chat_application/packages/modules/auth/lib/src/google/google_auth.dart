import 'package:auth/src/google/google_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleAuthController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Google Login"),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () => controller.openBottomSheetToEnterPhoneNumber(),),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            WidgetStatePropertyAll(Size(Get.width, 50))),
                    onPressed: () {
                      controller.loginWithGoogle();
                    },
                    child: const Text("Login With Google")),
              ],
            ),
          ),
        );
      },
    );
  }
}
