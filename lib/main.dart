import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/Controllers/auth_controller.dart';
import 'package:my_app/Controllers/cart_provider.dart';
import 'package:my_app/Controllers/fav_controller.dart';
import 'package:my_app/Controllers/main_screen_provider.dart';
import 'package:my_app/Controllers/order_controller.dart';
import 'package:my_app/Controllers/product_provider.dart';
import 'package:my_app/Controllers/quantity_controller.dart';
import 'package:my_app/Controllers/textfield_controller.dart';
import 'package:my_app/Models/shoe_cart_model.dart';
import 'package:my_app/Screens/auth_screen.dart';
import 'package:my_app/Screens/verified_email_screen.dart';
import 'package:my_app/Utils/screen_size.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize hive
  await Hive.initFlutter();

  // Register the adapter

  Hive.registerAdapter(CartModelAdapter());
  // Open hive
  await Hive.openBox<CartModel>('cart_box');
  await Hive.openBox('fav_box');
  await Hive.openBox('total_box');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MainScreenProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductController(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => FavController(),
      ),
      ChangeNotifierProvider(
        create: (context) => TextFieldController(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthController(),
      ),
      ChangeNotifierProvider(
        create: (context) => QuantityController(),
      ),
      ChangeNotifierProvider(
        create: (context) => OrderController(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box<CartModel> box;
  late Box<dynamic> fav_box;
  late Box<dynamic> total_box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<CartModel>('cart_box');
    fav_box = Hive.box('fav_box');
    total_box = Hive.box('total_box');
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<CartProvider>().setTotal(total_box.get('total') ?? 0.0);
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(screenWidth, screenHeight),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Athletic shoes collection',
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const VerifyEmail();
              } else {
                return const AuthScreen();
              }
            },
          ),
        );
      },
    );
  }
}
