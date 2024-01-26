import 'package:flutter/cupertino.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';

class LineDivider extends StatelessWidget {
  const LineDivider({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: 1,
        color: ColorRes.divider,
      );
}
