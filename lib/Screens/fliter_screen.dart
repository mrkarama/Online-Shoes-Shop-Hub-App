import 'import.dart';
import 'packages.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> gender = ['Men', 'Women', 'Kids'];
  List<String> category = ['Shoes', 'Appareils', 'Accessories'];
  List<String> brand = [
    'assets/images/adidas.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
  ];

  double _value = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalHeight(10.h),
            Center(
              child: reusableText(
                'Filters',
                Colors.black,
                20.sp,
                1.h,
                FontWeight.bold,
              ),
            ),
            verticalHeight(25),
            Center(
              child: reusableText(
                'Gender',
                Colors.black87,
                15.sp,
                1.h,
                FontWeight.bold,
              ),
            ),
            verticalHeight(15),
            HorizontalChoiceChip(
              gender: gender,
              type: false,
            ),
            verticalHeight(20),
            Center(
              child: reusableText(
                'Category',
                Colors.black87,
                15.sp,
                1.h,
                FontWeight.bold,
              ),
            ),
            verticalHeight(15),
            HorizontalChoiceChip(
              gender: category,
              type: false,
            ),
            verticalHeight(20),
            Center(
              child: reusableText(
                'Price',
                Colors.black87,
                15.sp,
                1.h,
                FontWeight.bold,
              ),
            ),
            verticalHeight(15),
            Center(
              child: reusableText(
                '\$ ${_value.toInt().toString()}',
                Colors.black87,
                18.sp,
                1.h,
                FontWeight.bold,
              ),
            ),
            Slider(
              value: _value,
              divisions: 500,
              //label: _value.toInt().toString(),
              min: 0,
              max: 500,
              thumbColor: Colors.black,
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            verticalHeight(25),
            Center(
              child: reusableText(
                'Brand',
                Colors.black87,
                18.sp,
                1.h,
                FontWeight.bold,
              ),
            ),
            verticalHeight(20),
            HorizontalChoiceChip(
              gender: brand,
              type: true,
            ),
            verticalHeight(25),
          ]),
    );
  }
}
