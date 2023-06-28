import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SquareTile extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  const SquareTile({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: Colors.black,
            size: 40.sp,
          ),
        ),
      ),
    );
  }
}
