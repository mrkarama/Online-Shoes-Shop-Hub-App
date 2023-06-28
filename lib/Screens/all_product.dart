import 'import.dart';
import 'packages.dart';

class AllProducts extends StatefulWidget {
  final TabController tabController;
  const AllProducts({super.key, required this.tabController});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts>
    with TickerProviderStateMixin {
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMenSneakers();
  }

  void getFemale() {
    _female = Helper().getWomenSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  Future<void> filter(BuildContext context) {
    return showModalBottomSheet(
      barrierColor: Colors.transparent.withOpacity(0.1),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return const FilterScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/top_image.png',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 8.h),
              child: Positioned(
                top: 10.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNav(
                      icon: Icons.close,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    BottomNav(
                      icon: Icons.tune,
                      onTap: () {
                        filter(context);
                      },
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 45.h, left: 15.w),
              child: TabBar(
                controller: widget.tabController,
                isScrollable: true,
                labelColor: Colors.white,
                labelStyle: appstyle(15.sp, FontWeight.bold, Colors.white),
                labelPadding: EdgeInsets.only(right: 50.w),
                indicatorColor: Colors.transparent,
                tabs: const [
                  Tab(
                    text: 'Men Shoes',
                  ),
                  Tab(
                    text: 'women Shoes',
                  ),
                  Tab(
                    text: 'Kids Shoes',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.w, top: screenHeight * 0.14.h, right: 15.w),
              child: TabBarView(
                controller: widget.tabController,
                children: [
                  ProductWidget(gender: _male),
                  ProductWidget(gender: _female),
                  ProductWidget(gender: _kids),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
