import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final bool isLoading;

  final Widget widget;

  const AppScaffold({super.key, required this.isLoading, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget,
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox(),
      ],
    );
  }
}
