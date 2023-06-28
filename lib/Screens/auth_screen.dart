import 'import.dart';
import 'packages.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            SizedBox(
              width: screenWidth.w,
              height: screenHeight * 0.38.h,
              child: Image.asset(
                'assets/images/top_image.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.w,
                top: screenHeight * 0.39.h,
                right: 15.w,
                bottom: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(
                    'Shoes Hub',
                    Colors.black,
                    30.sp,
                    0.h,
                    FontWeight.bold,
                  ),
                  verticalHeight(10),
                  reusableTextWithMaxLines(
                    'We deliver shoes at any point of the earth in the fastest way possible',
                    Colors.black,
                    2,
                    18.sp,
                    0.h,
                    FontWeight.normal,
                  ),
                  // verticalHeight(30),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                15.w,
                0,
                15.w,
                20.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    title: 'Log in',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LogInScreen(),
                        ),
                      );
                    },
                  ),
                  verticalHeight(5),
                  CustomButton2(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    name: 'Sign up',
                  ),
                  verticalHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        icon: FontAwesomeIcons.google,
                        onTap: () {
                          try {
                            context.read<AuthController>().signInWithGoogle();

                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((User? user) {
                              if (user != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const MainScreen(),
                                    ),
                                    (route) => false);
                              }
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              ShowSnackbar().showSnackbar(
                                e.toString(),
                              ),
                            );
                          }
                        },
                      ),
                      horizontalWidth(15),
                      SquareTile(
                        icon: FontAwesomeIcons.facebook,
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
