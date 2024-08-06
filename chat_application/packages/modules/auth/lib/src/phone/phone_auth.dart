import 'package:auth/src/phone/phone_auth_controller.dart';
import 'package:custom_widgets/app_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneAuthController>(
      builder: (controller) => AppScaffold(
        isLoading: controller.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Phone Auth"),
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoTextFormFieldRow(
                    keyboardType: TextInputType.phone,
                    controller: controller.phoneNumberTextEditingController,
                    style: const TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                    placeholder: "Mobile Number",
                    placeholderStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: CupertinoColors.placeholderText),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  controller.isOtpSend?CupertinoTextFormFieldRow(
                    keyboardType: TextInputType.phone,
                    controller: controller.otpTextEditingController,
                    style: const TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                    placeholder: "OTP",
                    placeholderStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        color: CupertinoColors.placeholderText),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                  ):const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  !controller.isOtpSend?CupertinoButton(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    child: const Text("Send OTP"),
                    onPressed: () => controller.sendOtp(
                        phoneNumber:
                            "+91 ${controller.phoneNumberTextEditingController.text}"),
                  ):CupertinoButton(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    child: const Text("Verify OTP"),
                    onPressed: () => controller
                        .verify(controller.otpTextEditingController.text),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => controller.sendOtp(phoneNumber: "+916386506352"),
            child: const Icon(
              CupertinoIcons.upload_circle,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
