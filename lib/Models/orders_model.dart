class MyOrder {
  final String? name;
  final String userName;
  final String category;
  final double totalPrice;
  final String imageUrl;
  final dynamic quantity;
  final String id;

  MyOrder(
      {required this.name,
      required this.category,
      required this.userName,
      required this.totalPrice,
      required this.imageUrl,
      required this.quantity,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      'name': name ?? '',
      'category': category,
      'price': totalPrice,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'id': id,
      'userName': userName
    };
  }

  static MyOrder fromJson(Map<String, dynamic> json) {
    return MyOrder(
        name: json['name'] ?? '',
        category: json['category'],
        userName: json['userName'],
        totalPrice: json['price'],
        imageUrl: json['imageUrl'],
        quantity: json['quantity'],
        id: json['id']);
  }
}
