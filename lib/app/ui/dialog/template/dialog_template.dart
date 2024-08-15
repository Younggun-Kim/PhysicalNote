import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogTemplate extends StatelessWidget {
  final EdgeInsets padding;

  final Color backgroundColor;

  final VoidCallback? onClose;

  final Widget child;

  const DialogTemplate({
    super.key,
    this.padding = EdgeInsets.zero,
    this.backgroundColor = Colors.transparent,
    this.onClose,
    required this.child,
  });

  void _close() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: onClose ?? _close,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: backgroundColor,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
              ),
            ),
            Center(
              child: Padding(
                padding: padding,
                child: child,
              ),
            )
          ],
        ),
      );
}
