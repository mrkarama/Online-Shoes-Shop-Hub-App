import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Controllers/textfield_controller.dart';
import 'package:my_app/Screens/login_screen.dart';
import 'package:my_app/Screens/main_screen.dart';
import 'package:my_app/Utils/colors.dart';
import 'package:my_app/Utils/custom_button.dart';
import 'package:my_app/Utils/custom_button2.dart';
import 'package:my_app/Utils/custom_snackbar.dart';
import 'package:my_app/Utils/custom_text_field.dart';
import 'package:my_app/Utils/reusable_dimensions.dart';
import 'package:my_app/Utils/reusable_text.dart';
import 'package:my_app/Utils/screen_size.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (_formKey.currentState!.validate()) {
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user != null) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
                (route) => false,
              );
            }
          });
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(ShowSnackbar().showSnackbar(e.message!));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          ShowSnackbar().showSnackbar('Passwords don\'t match'),
        );
      }
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

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
                height: screenHeight * 0.45.h,
                child: Image.asset(
                  'assets/images/top_image.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: 15.w,
                top: screenHeight * 0.18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reusableText(
                      'Create',
                      Colors.white,
                      25.sp,
                      0.h,
                      FontWeight.normal,
                    ),
                    verticalHeight(5),
                    reusableText(
                      'Account',
                      Colors.white,
                      25.sp,
                      0.h,
                      FontWeight.normal,
                    ),
                  ],
                ),
              ),
              Positioned(
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LogInScreen(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  15.w,
                  screenHeight * 0.48.h,
                  15.w,
                  20.h,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        name: 'email',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black87,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _emailController.clear();
                          },
                          icon: _emailController.text.isEmpty
                              ? const Text('')
                              : const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                        ),
                        hintText: 'bande@gmail.com',
                      ),
                      verticalHeight(20),
                      CustomTextField(
                        controller: _passwordController,
                        name: 'password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: Consumer<TextFieldController>(
                          builder: (context, textFieldController, child) {
                            return IconButton(
                              onPressed: () {
                                textFieldController.setVisibility();
                              },
                              icon: textFieldController.isPassVisible
                                  ? const Icon(
                                      Icons.visibility,
                                      color: Colors.black54,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black87,
                                    ),
                            );
                          },
                        ),
                        hintText: 'Password',
                      ),
                      verticalHeight(20),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        name: 'Confirm Password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: Consumer<TextFieldController>(
                          builder: (context, textFieldController, child) {
                            return IconButton(
                              onPressed: () {
                                textFieldController.setVisibility();
                              },
                              icon: textFieldController.isPassVisible
                                  ? const Icon(
                                      Icons.visibility,
                                      color: Colors.black54,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black87,
                                    ),
                            );
                          },
                        ),
                        hintText: 'Confirm Password',
                      ),
                      verticalHeight(24),
                      CustomButton(
                        title: 'Sign up',
                        onTap: signUp,
                      ),
                      verticalHeight(8),
                      Row(children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 3.w,
                            right: 3.w,
                          ),
                          child: reusableText(
                            'Or',
                            Colors.black,
                            13.sp,
                            0.h,
                            FontWeight.normal,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ]),
                      verticalHeight(8),
                      CustomButton2(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LogInScreen(),
                            ),
                          );
                        },
                        name: 'Log in',
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
