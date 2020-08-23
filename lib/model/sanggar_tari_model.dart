import 'package:flutter/material.dart';

class SanggarTariModel {
  final String SanggarName;
  final String Description;
  final double RatingReview;
  final String OwnerSanggar;

  SanggarTariModel(
      {@required this.Description,
      @required this.OwnerSanggar,
      @required this.RatingReview,
      @required this.SanggarName});
}
