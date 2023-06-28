import 'import.dart';
import 'packages.dart';

class HomeWidget extends StatefulWidget {
  final Future<List<Sneakers>> gender;
  final TabController tabController;
  const HomeWidget(
      {super.key, required this.gender, required this.tabController});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.48.h,
            child: FutureBuilder<List<Sneakers>>(
              future: widget.gender,
              builder: (BuildContext context, snapshot) {
                final sneakers = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sneakers!.length,
                      itemBuilder: (context, index) {
                        final data = sneakers[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OneProductDetails(
                                    id: data.id, category: data.category)));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                width: screenWidth * 0.6.w,
                                height: screenHeight * 0.47.h,
                                color: Colors.white,
                                child: BuildListTile(
                                    name: data.name,
                                    id: data.id,
                                    sizes: data.sizes,
                                    category: data.category,
                                    price: data.price,
                                    imageUrl: data.imageUrl[0].toString()),
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.hasError.toString()));
                } else {
                  return SpinKitFadingCircle(itemBuilder: (context, index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                          color: index.isEven
                              ? Colors.deepOrange
                              : Colors.deepPurple),
                    );
                  });
                }
              },
            ),
          ),
          verticalHeight(20),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableText('Latest Shoes', Colors.black, 15.sp, 1.0.h,
                    FontWeight.bold),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AllProducts(
                          tabController: widget.tabController,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      reusableText(
                        'Show All',
                        Colors.black,
                        15.sp,
                        1.0.h,
                        FontWeight.normal,
                      ),
                      const Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          verticalHeight(10),
          SizedBox(
            height: screenHeight * 0.13.h,
            child: FutureBuilder<List<Sneakers>>(
              future: widget.gender,
              builder: (BuildContext context, snapshot) {
                final sneakers = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sneakers!.length,
                      itemBuilder: (context, index) {
                        final data = sneakers[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OneProductDetails(
                                      id: data.id, category: data.category),
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 5.w, right: 10.w, bottom: 20.h),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(width: 0.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(1.w, 1.h),
                                          blurRadius: 0.6.r,
                                          spreadRadius: 1.r,
                                        ),
                                      ]),
                                  width: 100.w,
                                  height: 80.h,
                                  child: Image.network(
                                    data.imageUrl[0],
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.hasError.toString()));
                } else {
                  return SpinKitFadingCircle(itemBuilder: (context, index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                          color: index.isEven
                              ? Colors.deepOrange
                              : Colors.deepPurple),
                    );
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
