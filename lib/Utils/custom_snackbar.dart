import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Utils/reusable_text.dart';

class ShowSnackbar {
  SnackBar showSnackbar(String message) {
    return SnackBar(
      elevation: 0,
      margin: EdgeInsets.fromLTRB(
        5.w,
        5.h,
        5.w,
        5.h,
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
      content: Center(
        child: reusableTextWithMaxLines(
          message,
          Colors.black,
          3,
          15.sp,
          1.5.h,
          FontWeight.normal,
        ),
      ),
    );
  }
}
