import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final bool isLoading;

  final Widget child;

  const AppScaffold({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox(),
      ],
    );
  }
}
