import 'package:flutter/material.dart';

class KindOfTarianModel {
  final String nameTarian;
  final String nameAuthor;
  final double reviews;
  final String descriptionTarian;

  KindOfTarianModel(
      {@required this.descriptionTarian,
      @required this.nameAuthor,
      @required this.nameTarian,
      @required this.reviews});
}
