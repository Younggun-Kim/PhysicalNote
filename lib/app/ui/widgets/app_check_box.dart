import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/resources/resources.dart';

class AppCheckbox extends StatelessWidget {
  final String text;

  final bool isChecked;

  final EdgeInsets? padding;

  final TextStyle? textStyle;

  final CrossAxisAlignment crossAxisAlignment;

  final Widget? menu;

  final void Function()? onToggle;

  get hasMenu => menu != null;

  const AppCheckbox({
    super.key,
    this.text = "",
    required this.isChecked,
    this.onToggle,
    this.padding,
    this.textStyle,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.menu,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Container(
          padding: padding ?? EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              AnimatedCrossFade(
                firstChild: SvgPicture.asset(
                  Assets.checkOn,
                  fit: BoxFit.contain,
                ),
                secondChild: SvgPicture.asset(
                  Assets.checkOff,
                  fit: BoxFit.contain,
                ),
                crossFadeState: isChecked
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 100),
              ),
              const SizedBox(width: 6),
              Visibility(
                visible: text.isNotEmpty,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      text,
                      style: textStyle ?? const TextStyle(fontSize: 13),
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToLastDescent: false,
                        applyHeightToFirstAscent: false,
                      ),
                    ),
                  ),
                ),
              ),
              if (hasMenu) const SizedBox(width: 40),
              hasMenu
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: menu,
                    )
                  : const SizedBox()
            ],
          ),
        ),
        onTap: () {
          onToggle?.call();
        },
      );
}
