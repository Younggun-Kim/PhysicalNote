import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/resources/resources.dart';

class CustomFloatingBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorRes.border,
      shape: const CircleBorder(),
      elevation: 0,
      onPressed: onPressed,
      child: SvgPicture.asset(Assets.plusSm),
    );
  }
}
