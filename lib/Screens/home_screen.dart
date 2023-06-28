import 'import.dart';
import 'packages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  Future<void> loadMale() async {
    _male = Helper().getMenSneakers();
  }

  Future<void> loadFemale() async {
    _female = Helper().getWomenSneakers();
  }

  Future<void> loadKids() async {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    loadFemale();
    loadKids();
    loadMale();
  }

  void loadSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.setBool('isHome', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 3, vsync: this);
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              SizedBox(
                width: screenWidth.w,
                child: Image.asset(
                  'assets/images/top_image.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reusableText(
                      'Athletic Shoes',
                      Colors.white,
                      26.0.sp,
                      1.2.h,
                      FontWeight.bold,
                    ),
                    verticalHeight(5),
                    reusableText(
                      'Collection',
                      Colors.white,
                      26.0.sp,
                      1,
                      FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, top: screenWidth * 0.22.h),
                child: TabBar(
                  controller: _tabController,
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
                      text: 'Women Shoes',
                    ),
                    Tab(
                      text: 'Kids Shoes',
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, top: screenWidth * 0.4.h),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(
                      gender: _male,
                      tabController: _tabController,
                    ),
                    HomeWidget(
                      gender: _female,
                      tabController: _tabController,
                    ),
                    HomeWidget(
                      gender: _kids,
                      tabController: _tabController,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
