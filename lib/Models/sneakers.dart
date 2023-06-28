import 'package:flutter/material.dart';

class Sneakers {
  final id;
  final String name;
  final String category;
  final String price;
  final List<dynamic> imageUrl;
  final String title;
  final String description;
  final List<dynamic> sizes;

  const Sneakers(
      {Key? key,
      required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.sizes});

  factory Sneakers.fromJson(Map<String, dynamic> json) {
    return Sneakers(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
      sizes: json['sizes'],
    );
  }
}
