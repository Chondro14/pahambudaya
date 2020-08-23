import 'package:flutter/material.dart';

// ignore: camel_case_types
class DataDance {
  final String images;
  final String id;

  final String title;
  final String description;
  final double rating;
  final String instructor;
  final String price;
  final DataDance onPressed;

  const DataDance(
      {@required this.id,
      @required this.description,
      @required this.images,
      @required this.title,
      @required this.rating,
      @required this.instructor,
      @required this.price,
      @required this.onPressed});
}
