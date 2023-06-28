import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Controllers/order_controller.dart';
import 'package:my_app/Models/orders_model.dart';
import 'package:my_app/Screens/main_screen.dart';
import 'package:my_app/Utils/colors.dart';
import 'package:my_app/Utils/reusable_dimensions.dart';
import 'package:my_app/Utils/reusable_text.dart';
import 'package:my_app/Utils/screen_size.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.03.h,
              //left: 15.w,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.1.h,
              left: 0,
              right: 0,
              child: Center(
                child: reusableText(
                  'Order Details',
                  Colors.black,
                  25.sp,
                  0.h,
                  FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.18.h,
              left: 0,
              right: 0,
              child: Center(
                child: FutureBuilder<MyOrder?>(
                    future: context.watch<OrderController>().readDataToFirebase(
                        FirebaseAuth.instance.currentUser!.email.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final userDetails = snapshot.data!;
                        return Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.2.w,
                            right: screenWidth * 0.2.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              reusableText(
                                'User Name',
                                Colors.black,
                                20.sp,
                                0.h,
                                FontWeight.bold,
                              ),
                              verticalHeight(10),
                              reusableText(
                                userDetails.userName.toString(),
                                Colors.black,
                                15.sp,
                                0.h,
                                FontWeight.normal,
                              ),
                              reusableText(
                                'Shoe\'s Name',
                                Colors.black,
                                20.sp,
                                0.h,
                                FontWeight.bold,
                              ),
                              verticalHeight(10),
                              reusableTextWithMaxLines(
                                userDetails.name.toString(),
                                Colors.black,
                                2,
                                15.sp,
                                1.5.h,
                                FontWeight.normal,
                              ),
                              reusableText(
                                'Shoe\'s Category',
                                Colors.black,
                                20.sp,
                                0.h,
                                FontWeight.bold,
                              ),
                              verticalHeight(10),
                              reusableText(
                                userDetails.category.toString(),
                                Colors.black,
                                15.sp,
                                0.h,
                                FontWeight.normal,
                              ),
                              reusableText(
                                'Shoe\'s Price',
                                Colors.black,
                                20.sp,
                                0.h,
                                FontWeight.bold,
                              ),
                              verticalHeight(10),
                              reusableText(
                                userDetails.totalPrice.round().toString(),
                                Colors.black,
                                15.sp,
                                0.h,
                                FontWeight.normal,
                              ),
                              reusableText(
                                'Shoe\'s Quantity',
                                Colors.black,
                                20.sp,
                                0.h,
                                FontWeight.bold,
                              ),
                              verticalHeight(10),
                              reusableText(
                                userDetails.quantity.toString(),
                                Colors.black,
                                15.sp,
                                0.h,
                                FontWeight.normal,
                              ),
                              reusableText(
                                'Shoe\'s ID',
                                Colors.black,
                                20.sp,
                                0.h,
                                FontWeight.bold,
                              ),
                              verticalHeight(10),
                              reusableText(
                                userDetails.id.toString(),
                                Colors.black,
                                15.sp,
                                0.h,
                                FontWeight.normal,
                              ),
                              reusableText(
                                'Shoe\'s Image',
                                Colors.black,
                                20.sp,
                                0.h,
                                FontWeight.bold,
                              ),
                              verticalHeight(5),
                              Container(
                                width: screenWidth * 0.4.w,
                                height: screenHeight * 0.13.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Colors.black54),
                                ),
                                child: Image.network(
                                  userDetails.imageUrl.toString(),
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'error ${snapshot.error}',
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
