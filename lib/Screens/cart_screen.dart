import 'package:flutter_slidable/flutter_slidable.dart';

import 'import.dart';
import 'packages.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Box<CartModel> box;
  bool isHome = true;
  late SharedPreferences prefs;
  late Box<dynamic> total_box;

  @override
  void initState() {
    super.initState();
    loadPrefs();
    loadTotal();
    box = Hive.box<CartModel>('cart_box');
    total_box = Hive.box('total_box');
    print('isssss ${isHome}');
  }

  void loadPrefs() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      isHome = prefs.getBool('isHome')!;
    });
  }

  void loadTotal() {
    context.read<CartProvider>().getTotal;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: isHome
                          ? const Text('')
                          : const Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                            ),
                    ),
                    horizontalWidth(
                      screenWidth * 0.27.w,
                    ),
                    reusableText(
                      'My Cart',
                      Colors.black,
                      23.sp,
                      0.0.h,
                      FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10.h,
                top: screenHeight * 0.1,
                right: 10.h,
                child: SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.60,
                  child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box<CartModel> myBox1, child) {
                      List<int> keys = myBox1.keys.cast<int>().toList();

                      return keys.isNotEmpty
                          ? ListView.builder(
                              itemCount: keys.length,
                              itemBuilder: (context, index) {
                                int key = keys.reversed.toList()[index];
                                CartModel product = myBox1.get(key)!;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Slidable(
                                    key: Key(key.toString()),
                                    endActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          flex: 1,
                                          onPressed: (BuildContext context) {
                                            Navigator.of(context).pop();
                                            context
                                                .read<CartProvider>()
                                                .removeToCart(
                                                    context,
                                                    key,
                                                    double.parse(
                                                        product.price));
                                          },
                                          icon: Icons.edit,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.8),
                                          foregroundColor: Colors.deepPurple,
                                        ),
                                        SlidableAction(
                                          flex: 2,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8.r),
                                            bottomRight: Radius.circular(8.r),
                                          ),
                                          onPressed: (BuildContext context) {
                                            context
                                                .read<CartProvider>()
                                                .removeToCart(
                                                    context,
                                                    key,
                                                    double.parse(
                                                        product.price));
                                            //context
                                            // .read<CartProvider>()
                                            //  .decreaseTotal(
                                            //      double.parse(product.price));
                                          },
                                          icon: Icons.delete,
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.red,
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      width: screenWidth,
                                      height: screenHeight * 0.13.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 1.0.r,
                                            spreadRadius: 0.3.r,
                                            offset: Offset(0.2.w, 0.2.h),
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          5.w,
                                          5.h,
                                          5.w,
                                          5.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              product.imageUrl,
                                              fit: BoxFit.contain,
                                            ),
                                            horizontalWidth(23.w),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  reusableText(
                                                    product.title.length <= 15
                                                        ? product.title
                                                            .substring(0, 15)
                                                        : '${product.title.substring(0, 15)}...',
                                                    Colors.black,
                                                    16.sp,
                                                    0.0.h,
                                                    FontWeight.bold,
                                                  ),
                                                  verticalHeight(3.h),
                                                  reusableText(
                                                    product.category,
                                                    Colors.black,
                                                    16.sp,
                                                    0.0.h,
                                                    FontWeight.normal,
                                                  ),
                                                  verticalHeight(5.h),
                                                  reusableText(
                                                    '\$${product.price}',
                                                    Colors.black,
                                                    14.sp,
                                                    0.0.h,
                                                    FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomSquare(
                                                  onTap: () {
                                                    if (context
                                                            .read<
                                                                QuantityController>()
                                                            .quantity <
                                                        2) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .removeCurrentSnackBar();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        ShowSnackbar().showSnackbar(
                                                            'Oups! Quantity can be less than 1'),
                                                      );
                                                    } else {
                                                      context
                                                          .read<
                                                              QuantityController>()
                                                          .decrementQty();
                                                    }
                                                  },
                                                  icon: Icons.remove,
                                                  backgroundColor: Colors.grey,
                                                  iconColor: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                                Consumer<QuantityController>(
                                                  builder: (context,
                                                      quantityController,
                                                      child) {
                                                    return reusableText(
                                                      quantityController
                                                          .quantity
                                                          .toString(),
                                                      Colors.black,
                                                      12.sp,
                                                      0.0.h,
                                                      FontWeight.normal,
                                                    );
                                                  },
                                                ),
                                                CustomSquare(
                                                  onTap: () {
                                                    if (context
                                                            .read<
                                                                QuantityController>()
                                                            .quantity >
                                                        9) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .removeCurrentSnackBar();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        ShowSnackbar().showSnackbar(
                                                            'Oups! Quantity can be greater than 10'),
                                                      );
                                                    } else {
                                                      context
                                                          .read<
                                                              QuantityController>()
                                                          .incrementQty();
                                                    }
                                                  },
                                                  icon: Icons.add,
                                                  backgroundColor: Colors.black,
                                                  iconColor: Colors.white,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.cartShopping,
                                  size: screenWidth * 0.4.sp,
                                  color: Colors.amber,
                                ),
                                verticalHeight(60),
                                reusableText(
                                  'Empty Cart',
                                  Colors.black,
                                  25.sp,
                                  0.h,
                                  FontWeight.normal,
                                ),
                                verticalHeight(60),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: screenWidth * 0.1.w,
                                    right: screenWidth * 0.1.w,
                                  ),
                                  child: CustomButton(
                                    title: 'Add Item',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OneProductDetails(
                                                  id: '20',
                                                  category: 'Kids\' Running'),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 10.w,
                right: 10.w,
                bottom: screenHeight * 0.09.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: box.listenable(),
                      builder: (context, value, child) {
                        return value.isNotEmpty
                            ? reusableText(
                                'Total',
                                Colors.black,
                                19.sp,
                                0.0.h,
                                FontWeight.normal,
                              )
                            : const Text('');
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: box.listenable(),
                      builder: (context, value, child) {
                        return value.isNotEmpty
                            ? Consumer<CartProvider>(
                                builder: (context, myCartProvider, child) {
                                  return reusableText(
                                    '\$${myCartProvider.getTotal.round().toString()}',
                                    Colors.black,
                                    23.sp,
                                    0.0.h,
                                    FontWeight.bold,
                                  );
                                },
                              )
                            : const Text('');
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 5.h,
                left: 10.w,
                right: 10.w,
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    return value.isNotEmpty
                        ? ValueListenableBuilder(
                            valueListenable: box.listenable(),
                            builder: (context, myBox, child) {
                              List<int> keys = myBox.keys.cast<int>().toList();
                              return CustomButton(
                                title: 'Pay Cash',
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    barrierColor:
                                        Colors.transparent.withOpacity(0.5),
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            reusableText(
                                              'Confirm Order?',
                                              Colors.black,
                                              20.sp,
                                              0.h,
                                              FontWeight.bold,
                                            ),
                                            verticalHeight(10),
                                            reusableTextWithMaxLines(
                                              'Do you want to confirm the order?',
                                              Colors.black,
                                              2,
                                              15.sp,
                                              1.5.h,
                                              FontWeight.normal,
                                            ),
                                            verticalHeight(15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();

                                                    for (int i = 0;
                                                        i < keys.length;
                                                        i++) {
                                                      int key = keys[i];
                                                      final collectionRef =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'orders');
                                                      final docUser =
                                                          collectionRef.doc();
                                                      final product =
                                                          myBox.get(key);
                                                      final userName =
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .displayName
                                                              .toString();

                                                      final order = MyOrder(
                                                        name: product!.title,
                                                        userName: userName,
                                                        category:
                                                            product.category,
                                                        totalPrice: context
                                                            .read<
                                                                CartProvider>()
                                                            .getTotal,
                                                        imageUrl:
                                                            product.imageUrl,
                                                        quantity: context
                                                            .read<
                                                                QuantityController>()
                                                            .quantity,
                                                        id: docUser.id,
                                                      );

                                                      context
                                                          .read<
                                                              OrderController>()
                                                          .writeOrderToFirestore(
                                                              order);
                                                    }

                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const OrderDetailsScreen(),
                                                      ),
                                                    );
                                                  },
                                                  child: reusableText(
                                                    'Yes',
                                                    Colors.black,
                                                    15.sp,
                                                    0.h,
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: reusableText(
                                                    'No',
                                                    Colors.black,
                                                    15.sp,
                                                    0.h,
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          )
                        : const SizedBox(
                            width: 0,
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
