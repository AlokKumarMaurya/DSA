import 'package:auth/src/email_password/email_password_controller.dart';
import 'package:custom_widgets/app_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

class EmailPassword extends StatelessWidget {
  const EmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailPasswordController>(
      builder: (controller) {
        return AppScaffold(
          isLoading: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Email And Password login"),
            ),
            body: Column(
              children: [
                CupertinoTextFormFieldRow(
                  controller: controller.emailTextEditingController,
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  placeholder: "Email ID",
                  placeholderStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: CupertinoColors.placeholderText),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
                CupertinoTextFormFieldRow(
                  controller: controller.passwordTextEditingController,
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  placeholder: "Password",
                  placeholderStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: CupertinoColors.placeholderText),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(
                  height: 30,
                ),
                CupertinoButton(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  child: const Text("login"),
                  onPressed: () => controller.loginWithEmailAndPassword(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
