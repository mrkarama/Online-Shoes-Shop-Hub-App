import 'package:hive/hive.dart';
part 'shoe_cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel {
  @HiveField(0)
  final String imageUrl;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String price;

  const CartModel({
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.price,
  });
}
