import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Controllers/main_screen_provider.dart';
import 'package:my_app/Utils/bottom_nav_widgets.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 15.w, bottom: 15.h, right: 15.w),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNav(
              icon: Icons.home_outlined,
              onTap: () {
                context.read<MainScreenProvider>().onPageChanged(0);
              },
            ),
            BottomNav(
              icon: Icons.search_outlined,
              onTap: () {
                context.read<MainScreenProvider>().onPageChanged(1);
              },
            ),
            BottomNav(
              icon: Icons.favorite_outline,
              onTap: () {
                context.read<MainScreenProvider>().onPageChanged(2);
              },
            ),
            BottomNav(
              icon: Icons.shopping_cart_outlined,
              onTap: () {
                context.read<MainScreenProvider>().onPageChanged(3);
              },
            ),
            BottomNav(
              icon: Icons.person,
              onTap: () {
                context.read<MainScreenProvider>().onPageChanged(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}
