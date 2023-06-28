import 'package:flutter/material.dart';
import 'package:my_app/Utils/reusable_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: reusableText(
          'Search Screen', Colors.black, 20.0, 1, FontWeight.normal),
    );
  }
}
