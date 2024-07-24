import 'package:admin_user/src/screens/demo/demo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

class DemoUi extends StatelessWidget {
  const DemoUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => controller.createDb(),
          child: const Icon(
            CupertinoIcons.upload_circle,
            size: 40,
          ),
        ),
      ),
    );
  }
}
