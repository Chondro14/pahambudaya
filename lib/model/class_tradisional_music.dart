import 'package:flutter/material.dart';

// ignore: camel_case_types
class Traditional_Music_Model {
  final String image;
  final String id;

  final String title;
  final String description;
  final double rating;
  final String instructor;
  final String price;

  const Traditional_Music_Model(
      {@required this.id,
      @required this.image,
      @required this.description,
      @required this.title,
      @required this.rating,
      @required this.instructor,
      @required this.price});
}
