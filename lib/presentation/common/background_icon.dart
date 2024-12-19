import 'package:flutter/material.dart';

class BackgroundIcon extends StatelessWidget {
  const BackgroundIcon({
    Key? key,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);
  final Widget icon;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: icon,
    );
  }
}
