import 'package:flutter/cupertino.dart';

class data_Carousel {
  final String image;
  final String id;
  final Function onPressed;
  final String title;
  final String description;

  data_Carousel(
      {@required this.id,
      @required this.image,
      @required this.onPressed,
      @required this.description,
      @required this.title});
}
