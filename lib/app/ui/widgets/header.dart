import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

class Header extends StatelessWidget {
  final String title;
  final bool showBack;
  final EdgeInsets padding;
  final VoidCallback? onPressed;
  final Widget? menu;
  get hasMenu => menu != null;

  const Header({
    super.key,
    required this.title,
    this.showBack = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.onPressed,
    this.menu,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: 60,
    color: ColorRes.white,
    padding: padding,
    child: Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: _title(context),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Transform.translate(
            offset: const Offset(-10, 0),
            child: _back(),
          ),
        ),
        hasMenu
            ? Align(
          alignment: Alignment.centerRight,
          child: menu,
        )
            : const SizedBox()
      ],
    ),
  );

  Widget _title(BuildContext context) => Text(
    title,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      fontSize: 18,
      color: ColorRes.fontBlack,
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _back() => Visibility(
    visible: showBack,
    child: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
      iconSize: 24,
      color: Colors.black,
      onPressed: onPressed,
    )
  );
}
