import 'package:flutter/material.dart';
import 'package:pahambudaya/model/Material_Traditional_Gandrung.dart';
import 'package:pahambudaya/screen/dancedetail.dart';
import 'package:rating_bar/rating_bar.dart';

class DanceItem extends StatelessWidget {
  final String images;
  final String id;
  final String price;
  final String author;
  final String title;
  final String description;
  final double rating;
  final DataDance onPressed;

  const DanceItem(
      {@required this.rating,
      @required this.title,
      @required this.description,
      @required this.images,
      @required this.id,
      @required this.price,
      @required this.author,
      this.onPressed});

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
          builder: (context) => Dancedetail(
                mantapWes: onPressed,
              ),
          settings: RouteSettings(arguments: id)),
    )
        .then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          selectMeal(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              color: Colors.white),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
                child: Image.network(
                  images,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Mulish'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  author,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      initialRating: rating,
                      filledColor: Colors.yellow,
                      emptyColor: Colors.yellow,
                      size: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        rating.toString(),
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  price,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 30,
                  color: Colors.orange,
                  child: MaterialButton(
                    color: Colors.yellow[900],
                    onPressed: null,
                    child: Center(
                      child: Text(
                        'Lihat Kelas ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
