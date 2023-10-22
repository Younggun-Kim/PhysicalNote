import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class OutlineTextField extends StatelessWidget {
  // Container
  final double? height;

  // TextField
  final TextEditingController controller;

  final int? maxLength;

  final TextInputType keyboardType;

  final bool obscureText; // 암호화 여부.

  // - Decoration
  final String hint;

  final EdgeInsets contentPadding;

  // - Font
  final double fontSize;

  final Color? textColor;

  final FontWeight? fontWeight;

  // Right Widget
  final bool isShowSearch;

  final VoidCallback? onPressedSearch;

  final Widget rightWidget;

  /// 생성자.
  const OutlineTextField({
    Key? key,
    this.height = 56,
    required this.controller,
    this.maxLength,
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText = false,
    this.hint = "",
    this.contentPadding = const EdgeInsets.all(16),
    this.fontSize = 16,
    this.textColor = ColorRes.fontBlack,
    this.fontWeight = FontWeight.w400,
    this.isShowSearch = false,
    this.onPressedSearch,
    this.rightWidget = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius =
        BorderRadius.circular(MediaQuery.of(context).size.height * 0.5);

    return Container(
        width: double.infinity,
        height: 56,
        alignment: Alignment.center,
        padding: contentPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorRes.borderWhite),
          borderRadius: borderRadius,
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
              child: TextField(
                controller: controller,
                maxLength: maxLength,
                keyboardType: keyboardType,
                obscureText: obscureText,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    fontSize: fontSize,
                    color: ColorRes.fontDisable,
                    fontWeight: fontWeight,
                  ),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  counterText: '',
                ),
              ),
            ),
            Visibility(
              visible: isShowSearch,
              child: InkWellOver(
                onTap: onPressedSearch,
                splashColor: null,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: SvgPicture.asset(Assets.searchRefraction),
                ),
              ),
            ),
            rightWidget
          ],
        ));
  }
}
