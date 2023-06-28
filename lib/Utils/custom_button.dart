import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Utils/reusable_text.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
          child: reusableText(
            title,
            Colors.white,
            15.sp,
            0.h,
            FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
