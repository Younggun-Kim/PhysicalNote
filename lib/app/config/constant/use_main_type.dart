import 'package:get/get.dart';

enum UseMain {
  none,
  foot,
  hand,
  all;

  static UseMain from(String? rawValue) =>
      values.firstWhereOrNull((e) => e.name.toUpperCase() == rawValue) ??
      UseMain.none;
}

extension UseMainEx on UseMain {
  bool get isNone => this == UseMain.none;

  bool get isFoot => this == UseMain.foot;

  bool get isHand => this == UseMain.hand;

  bool get isAll => this == UseMain.all;
}
