import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Screens/fav_screen.dart';
import 'package:my_app/Utils/reusable_dimensions.dart';
import 'package:my_app/Utils/reusable_text.dart';
import 'package:provider/provider.dart';

import '../Controllers/fav_controller.dart';

class StaggerTile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String category;
  final List<dynamic> sizes;
  final String price;
  final String id;
  const StaggerTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.sizes,
    required this.id,
    required this.price,
  });

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() {
    context.read<FavController>().setIds();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> ids = context.watch<FavController>().getIds;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
          child: Stack(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.imageUrl,
                      fit: BoxFit.contain,
                    ),
                    verticalHeight(20),
                    reusableTextWithMaxLines(
                      widget.name,
                      Colors.black,
                      2,
                      20.sp,
                      1.2.h,
                      FontWeight.bold,
                    ),
                    verticalHeight(10),
                    reusableTextWithMaxLines(
                      '\$ ${widget.price}',
                      Colors.black87,
                      1,
                      20.sp,
                      0.h,
                      FontWeight.normal,
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 5.h,
                  right: 5.w,
                  child: GestureDetector(
                    onTap: () {
                      final product = {
                        'id': widget.id,
                        'name': widget.name,
                        'category': widget.category,
                        'imageUrl': widget.imageUrl,
                        'sizes': widget.sizes,
                      };
                      if (!ids.contains(widget.id)) {
                        context.read<FavController>().addToFavBox(product);
                        context.read<FavController>().setIds();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavScreen(),
                          ),
                        );
                      }
                    },
                    child: ids.contains(widget.id)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            color: Colors.grey,
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
