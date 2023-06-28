import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Controllers/textfield_controller.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  const CustomTextField(
      {super.key,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.hintText,
      required this.name,
      required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.name == 'email'
            ? false
            : context.watch<TextFieldController>().isPassVisible,
        controller: widget.controller,
        keyboardType: widget.name == 'email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          errorMaxLines: 3,
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon,
          hintStyle: GoogleFonts.poppins(
            color: Colors.black45,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0.w,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0.w,
            ),
          ),
          focusColor: Colors.deepPurple,
          errorStyle: GoogleFonts.poppins(
            color: Colors.red,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        validator: (value) {
          if (!(widget.name == 'email')) {
            final pattern = RegExp(
                r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$");

            if (value!.length < 8) {
              return 'Password must have at least 8 characters';
            }
            if (!pattern.hasMatch(value)) {
              return 'Use at least one upper caseletter, one lowercase English letter, one number and one special character';
            }

            return null;
          } else {
            final pattern = RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

            if (!pattern.hasMatch(value!)) {
              return 'Please enter a valid email';
            }
            if (value.isEmpty) {
              return 'Email can\'t be empty';
            }
            return null;
          }
        });
  }
}
