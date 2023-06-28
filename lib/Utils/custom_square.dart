import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSquare extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  const CustomSquare({
    super.key,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(3.r),
        ),
        child: Icon(
          icon,
          size: 15.sp,
          color: iconColor,
        ),
      ),
    );
  }
}
