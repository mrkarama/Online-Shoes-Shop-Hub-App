import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  const BottomNav({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
