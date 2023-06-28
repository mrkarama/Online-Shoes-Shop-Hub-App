import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Utils/reusable_text.dart';

class HorizontalChoiceChip extends StatefulWidget {
  final bool type;
  final List<String> gender;
  const HorizontalChoiceChip(
      {super.key, required this.gender, required this.type});

  @override
  State<HorizontalChoiceChip> createState() => _HorizontalChoiceChipState();
}

class _HorizontalChoiceChipState extends State<HorizontalChoiceChip> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.gender.length,
        (index) {
          return ChoiceChip(
            //visualDensity: VisualDensity.compact,
            elevation: 0,
            labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: const BorderSide(color: Colors.black, width: 1.0)),
            disabledColor: !(widget.type) ? Colors.white : Colors.black,
            selectedColor:
                !(widget.type) ? Colors.black : Colors.red.withOpacity(0.8),
            label: !(widget.type)
                ? reusableText(
                    widget.gender[index],
                    _value == index ? Colors.white : Colors.black,
                    10.sp,
                    1.h,
                    FontWeight.bold,
                  )
                : Image.asset(
                    widget.gender[index],
                    fit: BoxFit.contain,
                    width: 40.w,
                    height: 40.h,
                  ),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = (selected ? index : null)!;
              });
            },
          );
        },
      ).toList(),
    );
  }
}
