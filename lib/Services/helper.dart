import 'package:flutter/services.dart';
import 'package:my_app/Models/sneakers.dart';
import 'dart:convert';

class Helper {
  Future<List<Sneakers>> getKidsSneakers() async {
    final response = await rootBundle.loadString('assets/json/kids_shoes.json');

    final results = jsonDecode(response) as List<dynamic>;
    final sneakers = results.map((e) => Sneakers.fromJson(e)).toList();

    return sneakers;
  }

  Future<List<Sneakers>> getMenSneakers() async {
    final response = await rootBundle.loadString('assets/json/men_shoes.json');

    final results = jsonDecode(response) as List<dynamic>;

    final sneakers = results.map((e) => Sneakers.fromJson(e)).toList();

    return sneakers;
  }

  Future<List<Sneakers>> getWomenSneakers() async {
    final response =
        await rootBundle.loadString('assets/json/women_shoes.json');

    final results = jsonDecode(response) as List<dynamic>;
    final sneakers = results.map((e) => Sneakers.fromJson(e)).toList();

    return sneakers;
  }

  // Single Male by id

  Future<Sneakers> getSingleMaleById(String id) async {
    final data = await rootBundle.loadString('assets/json/men_shoes.json');

    final response = jsonDecode(data) as List<dynamic>;

    final results = response
        .map((e) => Sneakers.fromJson(e))
        .toList()
        .firstWhere((sneaker) => sneaker.id == id);

    return results;
  }

  // Single female by id

  Future<Sneakers> getSingleFemaleById(String id) async {
    final data = await rootBundle.loadString('assets/json/women_shoes.json');

    final response = jsonDecode(data) as List<dynamic>;

    final results = response
        .map((e) => Sneakers.fromJson(e))
        .toList()
        .firstWhere((sneaker) => sneaker.id == id);

    return results;
  }

  // Single kid by id

  Future<Sneakers> getSingleKidsById(String id) async {
    final data = await rootBundle.loadString('assets/json/kids_shoes.json');

    final response = jsonDecode(data) as List<dynamic>;

    final results = response
        .map((e) => Sneakers.fromJson(e))
        .toList()
        .firstWhere((sneaker) => sneaker.id == id);

    return results;
  }
}
