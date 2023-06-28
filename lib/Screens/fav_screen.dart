import 'import.dart';
import 'packages.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  late Box<dynamic> fav_box;

  @override
  void initState() {
    super.initState();
    fav_box = Hive.box('fav_box');
    loadIds();
  }

  void loadIds() {
    context.read<FavController>().setIds();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Image.asset(
              'assets/images/top_image.png',
              fit: BoxFit.fill,
            ),
            Positioned(
              left: 10.w,
              top: 3.h,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  horizontalWidth(
                    screenWidth * 0.23.w,
                  ),
                  reusableText(
                    'My Favorites',
                    Colors.white,
                    25.sp,
                    0.0.h,
                    FontWeight.bold,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 10.w, top: screenHeight * 0.1.h, right: 10.w),
              child: SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: ValueListenableBuilder(
                  valueListenable: fav_box.listenable(),
                  builder: (context, Box<dynamic> myFavBox, child) {
                    List<int> keys = myFavBox.keys.cast<int>().toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: keys.length,
                      itemBuilder: (context, index) {
                        List<dynamic> favList = [];
                        List<dynamic> listOfproduct = keys.map((key) {
                          Map<dynamic, dynamic> item = myFavBox.get(key);
                          return {
                            'key': key,
                            'id': item['id'],
                            'price': item['price'],
                            'title': item['title'],
                            'name': item['name'],
                            'category': item['category'],
                            'imageUrl': item['imageUrl'],
                            'sizes': item['sizes'],
                          };
                        }).toList();

                        favList = listOfproduct.reversed.toList();

                        final Map<String, dynamic> product = favList[index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Container(
                            width: screenWidth,
                            height: screenHeight * 0.12,
                            padding: EdgeInsets.fromLTRB(
                              7.w,
                              7.h,
                              7.w,
                              7.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.r),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.3.w, 0.3),
                                  blurRadius: 1.5.r,
                                  spreadRadius: 0.3.r,
                                )
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  product['imageUrl'].toString(),
                                  fit: BoxFit.contain,
                                ),
                                horizontalWidth(30.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      reusableTextWithMaxLines(
                                        product['name'],
                                        Colors.black,
                                        2,
                                        16.sp,
                                        0.0.h,
                                        FontWeight.bold,
                                      ),
                                      verticalHeight(3.h),
                                      reusableText(
                                        favList[index]['category'].toString(),
                                        Colors.black,
                                        16.sp,
                                        0.0.h,
                                        FontWeight.normal,
                                      ),
                                      verticalHeight(5.h),
                                      reusableText(
                                        '\$${product['price'].toString()}',
                                        Colors.black,
                                        14.sp,
                                        0.0.h,
                                        FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<FavController>()
                                        .removeToFavBox(product['key']);
                                    context.read<FavController>().setIds();
                                    context
                                        .read<FavController>()
                                        .removeIds(product['key']);
                                    context.read<FavController>().setIds();
                                  },
                                  child: const Icon(
                                    Icons.heart_broken,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
