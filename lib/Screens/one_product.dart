import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:my_app/Controllers/cart_provider.dart';
import 'package:my_app/Controllers/fav_controller.dart';
import 'package:my_app/Controllers/product_provider.dart';
import 'package:my_app/Models/shoe_cart_model.dart';
import 'package:my_app/Models/sneakers.dart';
import 'package:my_app/Screens/cart_screen.dart';
import 'package:my_app/Screens/fav_screen.dart';
import 'package:my_app/Services/helper.dart';
import 'package:my_app/Utils/colors.dart';
import 'package:my_app/Utils/custom_button.dart';
import 'package:my_app/Utils/reusable_dimensions.dart';
import 'package:my_app/Utils/reusable_text.dart';
import 'package:my_app/Utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OneProductDetails extends StatefulWidget {
  final String id;
  final String category;
  const OneProductDetails(
      {super.key, required this.id, required this.category});

  @override
  State<OneProductDetails> createState() => _OneProductDetailsState();
}

class _OneProductDetailsState extends State<OneProductDetails> {
  double _initialRating = 0;
  int _selectedValue = 0;

  late Future<Sneakers> singleSneaker;
  late Box<CartModel> box;
  late Box<dynamic> fav_box;
  final PageController pageController = PageController();

  void getRightSneaker() {
    if (widget.category == "Kids' Running") {
      singleSneaker = Helper().getSingleKidsById(widget.id);
    } else if (widget.category == "Men's Running") {
      singleSneaker = Helper().getSingleMaleById(widget.id);
    } else {
      singleSneaker = Helper().getSingleFemaleById(widget.id);
    }
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box<CartModel>('cart_box');
    fav_box = Hive.box('fav_box');
    getRightSneaker();
    load();
  }

  void load() {
    context.read<FavController>().setIds();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> ids = context.watch<FavController>().getIds;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: backgroundColor,
              expandedHeight: screenHeight.h,
              centerTitle: true,
              pinned: true,
              floating: true,
              leading: GestureDetector(
                onTap: () {
                  context.read<ProductController>().getListOfSizes.clear();
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
              title: reusableText(
                widget.category == "Kids' Running"
                    ? "${widget.category.substring(0, 4)} Shoes"
                    : (widget.category == "Men's Running"
                        ? "${widget.category.substring(0, 3)} Shoes"
                        : "${widget.category.substring(0, 5)} Shoes"),
                Colors.black,
                20.sp,
                1.h,
                FontWeight.bold,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: SizedBox(
                  width: screenWidth.w,
                  height: double.maxFinite.h,
                  child: FutureBuilder<Sneakers>(
                    future: singleSneaker,
                    builder: (context, snapshot) {
                      final single = snapshot.data;
                      return Stack(
                        children: [
                          PageView.builder(
                            onPageChanged: (value) {
                              context
                                  .read<ProductController>()
                                  .setPageIndex(value);
                            },
                            itemCount: single!.imageUrl.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  SizedBox(
                                    width: screenWidth.w,
                                    height: screenHeight * 0.42.h,
                                    child: Image.network(
                                      single.imageUrl[index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Positioned(
                                    top: 80.h,
                                    right: 10.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        final product = {
                                          'id': single.id,
                                          'title': single.title,
                                          'price': single.price,
                                          'name': single.name,
                                          'category': single.category,
                                          'imageUrl': single.imageUrl[index],
                                          'sizes': single.sizes,
                                        };

                                        if (!ids.contains(single.id)) {
                                          context
                                              .read<FavController>()
                                              .addToFavBox(product);
                                          context
                                              .read<FavController>()
                                              .setIds();
                                        } else {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const FavScreen(),
                                            ),
                                          );
                                        }
                                      },
                                      child: ids.contains(single.id)
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.black,
                                            )
                                          : const Icon(
                                              Icons.favorite_outline,
                                              color: Colors.grey,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: screenHeight * 0.33.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          single.imageUrl.length, (index) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 4.w),
                                          child: CircleAvatar(
                                            backgroundColor: context
                                                        .watch<
                                                            ProductController>()
                                                        .pageIndex ==
                                                    index
                                                ? Colors.black
                                                : Colors.grey,
                                            radius: 4.r,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: screenHeight * 0.36.h),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r)),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.w, right: 15.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        verticalHeight(15),
                                        reusableTextWithMaxLines(
                                          single.name,
                                          Colors.black,
                                          2,
                                          20.sp,
                                          0.h,
                                          FontWeight.bold,
                                        ),
                                        verticalHeight(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            reusableTextWithMaxLines(
                                              single.category,
                                              Colors.black87,
                                              1,
                                              15.sp,
                                              0.0.h,
                                              FontWeight.normal,
                                            ),
                                            horizontalWidth(40),
                                            RatingBar.builder(
                                              itemSize: 20,
                                              initialRating: 0.0,
                                              maxRating: 5.0,
                                              onRatingUpdate: (value) {
                                                setState(() {
                                                  _initialRating = value;
                                                });
                                              },
                                              itemBuilder: (context, index) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.black,
                                                );
                                              },
                                              unratedColor: Colors.grey,
                                              updateOnDrag: true,
                                            ),
                                            horizontalWidth(7),
                                            reusableText(
                                              '${((_initialRating / 5) * 100).toString()} %',
                                              Colors.black87,
                                              15.sp,
                                              0.0.h,
                                              FontWeight.normal,
                                            ),
                                          ],
                                        ),
                                        verticalHeight(15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            reusableTextWithMaxLines(
                                              '\$${single.price}',
                                              Colors.black,
                                              1,
                                              15.sp,
                                              0.0.h,
                                              FontWeight.bold,
                                            ),
                                            Row(
                                              children: [
                                                reusableText(
                                                  'Colors',
                                                  Colors.grey,
                                                  15.sp,
                                                  0.0.h,
                                                  FontWeight.normal,
                                                ),
                                                horizontalWidth(12),
                                                Row(
                                                  children:
                                                      List.generate(2, (index) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.w),
                                                      child: CircleAvatar(
                                                        radius: 10.r,
                                                        child: ChoiceChip(
                                                          onSelected: (value) {
                                                            setState(() {
                                                              _selectedValue =
                                                                  (value
                                                                      ? index
                                                                      : null)!;
                                                            });
                                                          },
                                                          disabledColor:
                                                              Colors.grey,
                                                          selectedColor:
                                                              _selectedValue ==
                                                                      0
                                                                  ? Colors.black
                                                                  : Colors.red,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.r),
                                                              side: BorderSide(
                                                                  color: index ==
                                                                          0
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .red)),
                                                          label: const Text(''),
                                                          selected:
                                                              _selectedValue ==
                                                                  index,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        verticalHeight(15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            reusableText(
                                              'Select a size',
                                              Colors.black,
                                              15.sp,
                                              0.0.h,
                                              FontWeight.bold,
                                            ),
                                            horizontalWidth(13),
                                            reusableText(
                                              'View size guide',
                                              Colors.grey,
                                              13.sp,
                                              0.0.h,
                                              FontWeight.normal,
                                            ),
                                          ],
                                        ),
                                        verticalHeight(10),
                                        SizedBox(
                                          height: 40.h,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: single.sizes.length,
                                            itemBuilder: (context, index) {
                                              return Consumer<
                                                  ProductController>(
                                                builder: (context,
                                                    productController, child) {
                                                  List<dynamic> getSizes =
                                                      productController
                                                          .getListOfSizes;
                                                  getSizes = single.sizes;
                                                  return ChoiceChip(
                                                    side: const BorderSide(
                                                        color: Colors.black),
                                                    shape: const CircleBorder(),
                                                    disabledColor: Colors.white,
                                                    selectedColor: Colors.black,
                                                    label: reusableText(
                                                      getSizes[index]['size'],
                                                      getSizes[index]
                                                              ['isSelected']
                                                          ? Colors.white
                                                          : Colors.black,
                                                      13.sp,
                                                      1.0.h,
                                                      FontWeight.normal,
                                                    ),
                                                    selected: getSizes[index]
                                                        ['isSelected'],
                                                    onSelected: (value) {
                                                      context
                                                          .read<
                                                              ProductController>()
                                                          .setListOfSizes(
                                                              getSizes);
                                                      context
                                                          .read<
                                                              ProductController>()
                                                          .toggleIsSelected(
                                                              index, value);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        verticalHeight(10),
                                        Divider(
                                          indent: 15.w,
                                          endIndent: 15.w,
                                          thickness: 1,
                                          color: Colors.black,
                                        ),
                                        verticalHeight(10),
                                        reusableTextWithMaxLines(
                                          single.title,
                                          Colors.black,
                                          2,
                                          20.sp,
                                          1.5.h,
                                          FontWeight.bold,
                                        ),
                                        verticalHeight(13),
                                        reusableTextWithMaxLines(
                                          single.description,
                                          Colors.black54,
                                          2,
                                          15.sp,
                                          1.3.h,
                                          FontWeight.normal,
                                        ),
                                        verticalHeight(10),
                                        Positioned(
                                          bottom: 0.h,
                                          child: CustomButton(
                                            title: 'Add to cart',
                                            onTap: () async {
                                              final CartModel product =
                                                  CartModel(
                                                imageUrl: single.imageUrl[0],
                                                title: single.title,
                                                category: single.category,
                                                price: single.price,
                                              );
                                              context
                                                  .read<CartProvider>()
                                                  .addToCart(
                                                      product,
                                                      double.parse(
                                                          single.price));
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const CartScreen(),
                                              ));
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              setState(() {
                                                prefs.setBool('isHome', false);
                                              });
                                            },
                                          ),
                                        ),
                                        verticalHeight(10),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
