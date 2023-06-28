import 'package:flutter/material.dart';
import 'package:my_app/Controllers/main_screen_provider.dart';
import 'package:my_app/Screens/cart_screen.dart';
import 'package:my_app/Screens/fav_screen.dart';
import 'package:my_app/Screens/home_screen.dart';
import 'package:my_app/Screens/person_screen.dart';
import 'package:my_app/Screens/search_screen.dart';
import 'package:my_app/Utils/bottom_nav.dart';
import 'package:my_app/Utils/colors.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final List<Widget> _listOfScreens = const [
    HomeScreen(),
    SearchScreen(),
    FavScreen(),
    CartScreen(),
    PersonScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<MainScreenProvider>().getPageIndex;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        backgroundColor: backgroundColor,
        body: _listOfScreens[currentIndex],
      ),
    );
  }
}
