import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Controllers/auth_controller.dart';
import 'package:my_app/Screens/auth_screen.dart';
import 'package:my_app/Utils/colors.dart';
import 'package:my_app/Utils/custom_button.dart';
import 'package:my_app/Utils/person_tile.dart';
import 'package:my_app/Utils/reusable_dimensions.dart';
import 'package:my_app/Utils/reusable_text.dart';
import 'package:my_app/Utils/screen_size.dart';
import 'package:provider/provider.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                width: screenWidth.w,
                height: screenHeight * 0.4.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalHeight(3),
                    reusableText(
                      'profile',
                      Colors.black,
                      23.sp,
                      0.h,
                      FontWeight.bold,
                    ),
                    verticalHeight(13),
                    CircleAvatar(
                      radius: 51.5.r,
                      backgroundColor: Colors.black87,
                      child: Center(
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundColor: Colors.white,
                          child: FirebaseAuth.instance.currentUser!.photoURL !=
                                  null
                              ? Center(
                                  child: Image.network(
                                    FirebaseAuth.instance.currentUser!.photoURL
                                        .toString(),
                                    width: 70.w,
                                    height: 70.h,
                                  ),
                                )
                              : Stack(
                                  children: [
                                    Align(
                                      alignment: const Alignment(-0.55, -0.6),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.person,
                                          size: 60.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    verticalHeight(8),
                    FirebaseAuth.instance.currentUser!.displayName != null
                        ? reusableText(
                            FirebaseAuth.instance.currentUser!.displayName
                                .toString(),
                            Colors.black,
                            18.sp,
                            0.h,
                            FontWeight.normal,
                          )
                        : reusableText(
                            'Your Name',
                            Colors.black,
                            18.sp,
                            0.h,
                            FontWeight.normal,
                          ),
                    verticalHeight(2),
                    FirebaseAuth.instance.currentUser!.email != null
                        ? reusableText(
                            FirebaseAuth.instance.currentUser!.email.toString(),
                            Colors.black54,
                            15.sp,
                            0.h,
                            FontWeight.normal,
                          )
                        : reusableText(
                            'Your Email',
                            Colors.black54,
                            15.sp,
                            0.h,
                            FontWeight.normal,
                          ),
                    verticalHeight(10),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.3.w,
                        right: screenWidth * 0.3.w,
                      ),
                      child: CustomButton(
                        title: 'Edit Profile',
                        onTap: () {},
                      ),
                    ),
                    verticalHeight(10),
                    Expanded(
                      child: Divider(
                        endIndent: 15.w,
                        indent: 15.w,
                        thickness: 1.0,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  15.w,
                  screenHeight * 0.4.h,
                  15.w,
                  0.h,
                ),
                child: SizedBox(
                  width: screenWidth.w,
                  height: screenHeight * 0.6.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PersonTile(
                        name: 'Settings',
                        icon: Icons.settings,
                        onPressed: () {},
                      ),
                      PersonTile(
                        name: 'My orders',
                        icon: Icons.shopping_bag_outlined,
                        onPressed: () {},
                      ),
                      PersonTile(
                        name: 'Address',
                        icon: Icons.home_outlined,
                        onPressed: () {},
                      ),
                      PersonTile(
                        name: 'Change Password',
                        icon: Icons.lock_outline,
                        onPressed: () {},
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: Colors.black54,
                      ),
                      PersonTile(
                        name: 'Help & Support',
                        icon: Icons.help_outline,
                        onPressed: () {},
                      ),
                      verticalHeight(7),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          context.read<AuthController>().logoutMethod();
                          FirebaseAuth.instance.authStateChanges().listen(
                            (User? user) {
                              if (user == null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AuthScreen(),
                                    ),
                                    (route) => false);
                              }
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout_outlined,
                              color: Colors.black,
                            ),
                            horizontalWidth(20),
                            reusableText(
                              'Log out',
                              Colors.black,
                              17.sp,
                              0.h,
                              FontWeight.normal,
                            ),
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
      ),
    );
  }
}
