import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Cupertino Picker 커스텀 선택 오버레이
class CustomPickerSelectionOverlay extends StatelessWidget {
  /// Creates an iOS 14 style selection overlay that highlights the magnified
  /// area (or the currently selected item, depending on how you described it
  /// elsewhere) of a [CupertinoPicker].
  ///
  /// The [background] argument default value is
  /// [CupertinoColors.tertiarySystemFill].
  ///
  /// The [capStartEdge] and [capEndEdge] arguments decide whether to add a
  /// default margin and use rounded corners on the left and right side of the
  /// rectangular overlay, and they both default to true.
  const CustomPickerSelectionOverlay({
    super.key,
    this.background = CupertinoColors.tertiarySystemFill,
    this.capStartEdge = true,
    this.capEndEdge = true,
  });

  /// Whether to use the default use rounded corners and margin on the start side.
  final bool capStartEdge;

  /// Whether to use the default use rounded corners and margin on the end side.
  final bool capEndEdge;

  /// The color to fill in the background of the [CupertinoPickerDefaultSelectionOverlay].
  /// It Support for use [CupertinoDynamicColor].
  ///
  /// Typically this should not be set to a fully opaque color, as the currently
  /// selected item of the underlying [CupertinoPicker] should remain visible.
  /// Defaults to [CupertinoColors.tertiarySystemFill].
  final Color background;

  /// Default margin of the 'SelectionOverlay'.
  static const double _defaultSelectionOverlayHorizontalMargin = 20;

  /// Default radius of the 'SelectionOverlay'.
  static const double _defaultSelectionOverlayRadius = 20;

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(_defaultSelectionOverlayRadius);

    return Container(
      margin: EdgeInsetsDirectional.only(
        start: capStartEdge ? _defaultSelectionOverlayHorizontalMargin : 0,
        end: capEndEdge ? _defaultSelectionOverlayHorizontalMargin : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.horizontal(
          start: capStartEdge ? radius : Radius.zero,
          end: capEndEdge ? radius : Radius.zero,
        ),
        color: CupertinoDynamicColor.resolve(background, context),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.25),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
    );
  }
}
