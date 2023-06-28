import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Screens/main_screen.dart';
import 'package:my_app/Utils/reusable_dimensions.dart';
import 'package:my_app/Utils/reusable_text.dart';
import 'package:my_app/Utils/screen_size.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print('okkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    print(FirebaseAuth.instance.currentUser!.emailVerified);

    if (!isEmailVerified) {
      verfifyEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkIfEmailIsVerified();
      });
    }
  }

  Future<void> verfifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }

  Future<void> checkIfEmailIsVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      print('okkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      print(FirebaseAuth.instance.currentUser!.emailVerified);
    });
    if (isEmailVerified) {
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const MainScreen()
        : Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    width: screenWidth.w,
                    height: screenHeight * 0.45.h,
                    child: Image.asset(
                      'assets/images/top_image.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.5.h,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          reusableText(
                            'Verify your account',
                            Colors.black,
                            23.sp,
                            0.h,
                            FontWeight.bold,
                          ),
                          verticalHeight(20),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                            ),
                            child: reusableTextWithMaxLines(
                              'Account activation link has been sent to the e-mail address you provided',
                              Colors.black87,
                              2,
                              18.sp,
                              1.5.h,
                              FontWeight.normal,
                            ),
                          ),
                          verticalHeight(40),
                          Positioned(
                            bottom: 0.h,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.red,
                                  size: 60.sp,
                                ),
                                verticalHeight(10),
                                RichText(
                                  text: TextSpan(
                                    text: 'Didn\'t get the mail? ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: 'Send it again',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.blue,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
