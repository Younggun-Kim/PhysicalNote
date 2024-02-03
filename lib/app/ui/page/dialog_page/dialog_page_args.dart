class DialogPageArgs {
  final String text;

  final String yesText;

  final dynamic Function() onPressedYes;

  final String noText;

  final dynamic Function() onPressedNo;

  DialogPageArgs({
    required this.text,
    required this.yesText,
    required this.onPressedYes,
    required this.noText,
    required this.onPressedNo,
  }) ;
}
