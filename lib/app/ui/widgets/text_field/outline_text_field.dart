import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class OutlineTextField extends StatelessWidget {
  // Container
  final double? height;

  final Border? border;

  /// null이면 높이/2 로 자동 설정.
  final BorderRadius? borderRadius;

  final EdgeInsets? margin;

  final Color? color;

  // TextField
  final TextEditingController controller;

  final int? maxLength;

  final int? maxLines;

  final TextInputType keyboardType;

  final bool obscureText; // 암호화 여부.

  final bool expands;

  final List<TextInputFormatter>? inputFormatter;

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

  final Widget? rightWidget;

  final bool readOnly;

  /// 생성자.
  const OutlineTextField({
    Key? key,
    this.height = 56,
    this.border,
    this.borderRadius,
    this.margin,
    this.color = Colors.white,
    required this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText = false,
    this.expands = false,
    this.hint = "",
    this.inputFormatter,
    this.contentPadding = const EdgeInsets.all(16),
    this.fontSize = 16,
    this.textColor = ColorRes.fontBlack,
    this.fontWeight = FontWeight.w400,
    this.isShowSearch = false,
    this.onPressedSearch,
    this.rightWidget,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius defaultBorderRadius =
        BorderRadius.circular(MediaQuery.of(context).size.height * 0.5);

    return Container(
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      margin: margin,
      padding: contentPadding,
      decoration: BoxDecoration(
        color: readOnly ? ColorRes.disable : color,
        border: border ?? Border.all(color: ColorRes.borderWhite),
        borderRadius: borderRadius ?? defaultBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 1,
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
              expands: expands,
              maxLines: maxLines,
              keyboardType: keyboardType,
              obscureText: obscureText,
              readOnly: readOnly,
              style: TextStyle(
                fontSize: fontSize,
                color: readOnly ? ColorRes.white : textColor,
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
              inputFormatters: inputFormatter,
            ),
          ),
          Visibility(
            visible: isShowSearch,
            child: InkWellOver(
              onTap: onPressedSearch,
              splashColor: null,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, rightWidget == null ? 0 : 16, 0),
                child: SvgPicture.asset(Assets.searchRefraction),
              ),
            ),
          ),
          rightWidget ?? const SizedBox(),
        ],
      ),
    );
  }
}
