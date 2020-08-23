import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// ignore: camel_case_types
class Tutorial_video {
  // ignore: non_constant_identifier_names
  final String Title;

  // ignore: non_constant_identifier_names
  final String Description;

  // ignore: non_constant_identifier_names
  final double Rating;

  // ignore: non_constant_identifier_names
  final bool Favorite;
  final List<String> listTutorial;

  // ignore: non_constant_identifier_names
  const Tutorial_video(this.Description, this.Rating, this.Favorite,
      this.listTutorial,
      {@required this.Title});
}
