import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/utils/extensions/extensions.dart';

class CustomNaviBar extends StatelessWidget {
  final MainTabIndex current;

  final Function(MainTabIndex) onPressed;

  const CustomNaviBar({
    super.key,
    required this.current,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ColorRes.white,
        boxShadow: context.boxShadowTheme.md,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: BottomAppBar(
        elevation: 8,
        notchMargin: 12,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        color: ColorRes.white,
        shadowColor: Colors.black,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _getNavigationItem(
                      MainTabIndex.home,
                      current,
                    ),
                    _getNavigationItem(
                      MainTabIndex.feedback,
                      current,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _getNavigationItem(
                      MainTabIndex.history,
                      current,
                    ),
                    _getNavigationItem(
                      MainTabIndex.assignment,
                      current,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getNavigationItem(MainTabIndex type, MainTabIndex current) {
    final bool isSelected = type == current;

    return InkWell(
      onTap: () => onPressed(type),
      child: SvgPicture.asset(
        type.toAsset(isSelected),
        width: 24,
        height: 24,
      ),
    );
  }
}
