import 'package:flutter/material.dart';

// ignore: camel_case_types
class Class_recomendation {
  final String images;
  final String id;

  final String title;
  final String description;
  final double rating;
  final String instructor;
  final String price;
  final Class_recomendation onPressed;

  const Class_recomendation(
      {@required this.id,
      @required this.images,
      @required this.description,
      @required this.title,
      @required this.rating,
      @required this.instructor,
      @required this.price,
      @required this.onPressed});
}
