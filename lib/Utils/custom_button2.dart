import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Utils/reusable_text.dart';

class CustomButton2 extends StatelessWidget {
  final Function()? onTap;
  final String name;
  const CustomButton2({
    super.key,
    required this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(
            color: Colors.black,
            width: 1.0.w,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
          child: reusableText(
            name,
            Colors.black,
            15.sp,
            0.h,
            FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
