import 'package:auth/src/pages/auth_page_name.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Login to continue",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 1.5,
                    wordSpacing: 4,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size(Get.width, 50))),
                  onPressed: () {
                    Get.toNamed(AuthPageName.phoneAuth);
                  },
                  child: const Text(
                    "Continue with phone",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size(Get.width, 50))),
                  onPressed: () {
                    Get.toNamed(AuthPageName.emailAndPassword);
                  },
                  child: const Text(
                    "Continue with email and password",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size(Get.width, 50))),
                  onPressed: () {
                    Get.toNamed(AuthPageName.googleAuth);
                  },
                  child: const Text(
                    "Continue with Google",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
