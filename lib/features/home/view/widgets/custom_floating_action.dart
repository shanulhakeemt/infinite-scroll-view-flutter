import 'package:flutter/material.dart';

class CustomFloatingAction extends StatelessWidget {
  const CustomFloatingAction(
      {super.key, required this.icon, required this.onPress});

  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      child: Icon(icon),
    );
  }
}
