import 'package:flutter/material.dart';

class ArrowForwardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? iconColor;
  final double? iconSize;

  const ArrowForwardButton({
    super.key,
    required this.onPressed,
    this.iconColor = Colors.blue,
    this.iconSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.arrow_forward_ios),
      color: iconColor,
      iconSize: iconSize,
    );
  }
}