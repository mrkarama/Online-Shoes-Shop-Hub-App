import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_app/Models/sneakers.dart';
import 'package:my_app/Screens/one_product.dart';
import 'package:my_app/Screens/stagger_tile.dart';

class ProductWidget extends StatefulWidget {
  final Future<List<Sneakers>> gender;
  const ProductWidget({super.key, required this.gender});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: FutureBuilder<List<Sneakers>>(
          future: widget.gender,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final sneakers = snapshot.data;
              return StaggeredGridView.countBuilder(
                itemCount: sneakers!.length,
                mainAxisSpacing: 10.w,
                crossAxisSpacing: 10.h,
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(1, index.isEven ? 1.75 : 1.6);
                },
                itemBuilder: (context, index) {
                  final shoe = sneakers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OneProductDetails(
                              id: shoe.id, category: shoe.category)));
                    },
                    child: StaggerTile(
                      imageUrl: shoe.imageUrl[0],
                      category: shoe.category,
                      id: shoe.id,
                      sizes: shoe.sizes,
                      name: shoe.name,
                      price: shoe.price,
                    ),
                  );
                },
              );
            } else {
              return SpinKitThreeBounce(
                itemBuilder: (context, index) {
                  return DecoratedBox(
                      decoration: BoxDecoration(
                          color: index.isEven
                              ? Colors.deepOrange
                              : Colors.deepPurple));
                },
              );
            }
          },
        ));
  }
}
