import 'package:flutter/material.dart';

class RaisedButtonCustomWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color borderColor;
  final Function onPressed;

  const RaisedButtonCustomWidget({
    super.key,
    required this.icon,
    required this.text,
    this.borderColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: borderColor,
      onPressed: () => onPressed,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
