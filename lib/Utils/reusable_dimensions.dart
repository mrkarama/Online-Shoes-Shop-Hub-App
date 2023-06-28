import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget verticalHeight(double height) {
  return SizedBox(
    height: height.h,
  );
}

Widget horizontalWidth(double width) {
  return SizedBox(
    width: width.h,
  );
}
