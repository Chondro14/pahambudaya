import 'package:flutter/material.dart';
import 'package:pahambudaya/model/class_recomendation.dart';
import 'package:rating_bar/rating_bar.dart';

class DetailRecomendationClass extends StatefulWidget {
  DetailRecomendationClass({Key key, this.data2}) : super(key: key);
  final Class_recomendation data2;

  @override
  _DetailRecomendationClassState createState() =>
      _DetailRecomendationClassState(this.data2);
}

class _DetailRecomendationClassState extends State<DetailRecomendationClass> {
  _DetailRecomendationClassState(this.data2);

  Class_recomendation data2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.yellow[800],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1.5,
          child: Transform.translate(
            offset: Offset(0, 120),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0)),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      child: Image.network(data2.images),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data2.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          halfFilledColor: Colors.yellow,
                          emptyColor: Colors.yellow,
                          filledColor: Colors.yellow,
                          initialRating: data2.rating,
                          maxRating: 5,
                          size: 28,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data2.rating.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        data2.price,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Desciption',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      child: Text(
                        data2.description,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: null,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.search), onPressed: null),
                    Text(
                      'Cari...',
                      style: TextStyle(color: Colors.black26, fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: null),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 10,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data2.price,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: InkWell(
                    onTap: null,
                    splashColor: Colors.green,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.yellow[700], width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Beli',
                              style: TextStyle(
                                  color: Colors.yellow[700],
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ),
                        )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: InkWell(
                    onTap: null,
                    splashColor: Colors.green,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            color: Colors.yellow[800],
                            border: Border.all(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Kerajang',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ),
                            ],
                          ),
                        )),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
