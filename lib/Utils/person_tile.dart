import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Utils/reusable_dimensions.dart';
import 'package:my_app/Utils/reusable_text.dart';

class PersonTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function()? onPressed;
  const PersonTile({
    super.key,
    required this.name,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            horizontalWidth(20),
            reusableText(
              name,
              Colors.black,
              17.sp,
              0.h,
              FontWeight.normal,
            ),
          ],
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
