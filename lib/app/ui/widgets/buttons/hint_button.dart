import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

/// 힌트 버튼.
class HintButton extends StatelessWidget {
  final String text;

  final String hint;

  final VoidCallback? onTap;

  const HintButton({
    super.key,
    required this.text,
    required this.hint,
    this.onTap,
  });

  bool get hasText => text.isNotEmpty;

  @override
  Widget build(BuildContext context) => InkWellOver(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          height: 56,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
            color: ColorRes.white,
            border: Border.all(color: ColorRes.borderDeselect),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hasText ? text : hint,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: hasText ? ColorRes.fontBlack : ColorRes.fontDisable,
                  ),
                ),
              ),
              SvgPicture.asset(Assets.searchRefraction),
            ],
          ),
        ),
      );
}
