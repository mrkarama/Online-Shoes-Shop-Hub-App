import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Utils/reusable_dimensions.dart';
import 'package:my_app/Utils/reusable_text.dart';
import 'package:provider/provider.dart';

import '../Controllers/fav_controller.dart';
import '../Screens/fav_screen.dart';

class BuildListTile extends StatefulWidget {
  final String name;
  final String category;
  final String price;
  final String imageUrl;
  final List<dynamic> sizes;
  final String id;
  const BuildListTile(
      {super.key,
      required this.name,
      required this.id,
      required this.sizes,
      required this.category,
      required this.price,
      required this.imageUrl});

  @override
  State<BuildListTile> createState() => _BuildListTileState();
}

class _BuildListTileState extends State<BuildListTile> {
  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() {
    context.read<FavController>().setIds();
  }

  bool _isSelected = true;
  @override
  Widget build(BuildContext context) {
    List<dynamic> ids = context.watch<FavController>().getIds;
    return Padding(
      padding: EdgeInsets.fromLTRB(7.w, 7.h, 7.w, 7.h),
      child: Stack(
        children: [
          Positioned(
              top: 8.h,
              right: 8.h,
              child: GestureDetector(
                child: ids.contains(widget.id)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.grey,
                      ),
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
                    print(!ids.contains(widget.id));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavScreen(),
                      ),
                    );
                  }
                },
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              //verticalWidth(5),
              reusableText(
                widget.name,
                Colors.black,
                20.sp,
                1.h,
                FontWeight.bold,
              ),
              verticalHeight(8),
              reusableText(
                widget.category,
                Colors.black,
                15.sp,
                1.h,
                FontWeight.normal,
              ),
              verticalHeight(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reusableText(
                    '\$${widget.price}',
                    Colors.black,
                    18.sp,
                    1.h,
                    FontWeight.bold,
                  ),
                  Row(
                    children: [
                      reusableText(
                        'Colors',
                        Colors.black,
                        15.sp,
                        1.h,
                        FontWeight.normal,
                      ),
                      ChoiceChip(
                        backgroundColor: Colors.black.withOpacity(0.8),
                        label: Text(''),
                        selected: _isSelected,
                        selectedColor: Colors.black,
                        visualDensity: VisualDensity.compact,
                        onSelected: (value) {
                          setState(() {
                            _isSelected = value;
                          });
                        },
                      ),
                      ChoiceChip(
                        backgroundColor: Colors.grey.withOpacity(0.8),
                        label: Text(''),
                        selected: _isSelected,
                        selectedColor: Colors.grey,
                        visualDensity: VisualDensity.compact,
                        onSelected: (value) {
                          setState(() {
                            _isSelected = value;
                          });
                        },
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
