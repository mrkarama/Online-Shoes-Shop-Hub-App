import 'import.dart';
import 'packages.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool canResendInstructions = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _forgotPassController;

  @override
  void initState() {
    super.initState();
    _forgotPassController = TextEditingController();
  }

  @override
  void dispose() {
    _forgotPassController.dispose();
    super.dispose();
  }

  Future<void> forgotPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.sendPasswordResetEmail(
          email: _forgotPassController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          ShowSnackbar().showSnackbar(
              'We have sent a password recover instructions to your email.'),
        );

        setState(() {
          canResendInstructions = false;
        });
        await Future.delayed(Duration(seconds: 7));
        setState(() {
          canResendInstructions = true;
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          ShowSnackbar().showSnackbar(e.message!),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                top: 15.h,
                left: 15.w,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: screenHeight * 0.5.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reusableText(
                      'Reset Password',
                      Colors.black,
                      22.sp,
                      0.h,
                      FontWeight.bold,
                    ),
                    verticalHeight(12),
                    reusableTextWithMaxLines(
                      'Enter the email associated with your account and we\'ll send an email with instructions to reset your password.',
                      Colors.black,
                      3,
                      16.sp,
                      1.5.h,
                      FontWeight.normal,
                    ),
                    verticalHeight(15),
                    reusableText(
                      'Email address',
                      Colors.black87,
                      15.sp,
                      0.h,
                      FontWeight.normal,
                    ),
                    verticalHeight(3),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: TextFormField(
                        controller: _forgotPassController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          hintText: 'bande@gmail.com',
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black45,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0.w,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0.w,
                            ),
                          ),
                          focusColor: Colors.black,
                          errorStyle: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        validator: (value) {
                          final pattern = RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                          if (!pattern.hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          if (value.isEmpty) {
                            return 'Email can\'t be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    verticalHeight(7),
                    canResendInstructions
                        ? CustomButton(
                            title: 'Send Instructions', onTap: forgotPassword)
                        : const Text('')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
