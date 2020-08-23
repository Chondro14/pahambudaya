import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pahambudaya/model/Material_Traditional_Gandrung.dart';
import 'package:pahambudaya/widget/dance_item.dart';
import 'package:pahambudaya/widget/recomendation_item.dart';

import '../data_dummy.dart';
import 'map_screen.dart';

class HomeScreenMainView extends StatefulWidget {
  HomeScreenMainView({Key key}) : super(key: key);
  User user;

  @override
  _HomeScreenMainViewState createState() => _HomeScreenMainViewState();
}

class _HomeScreenMainViewState extends State<HomeScreenMainView> {
  var dataList = DummyImageCourse;
  List<DataDance> dataList2 = sweeeet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
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
                Icons.location_searching,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapScreen()));
                });
              }),
          IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {});
              }),
          IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 2,
          color: Colors.yellow[800],
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.orangeAccent,
                  child: Carousel(
                    boxFit: BoxFit.contain,
                    borderRadius: true,
                    autoplay: true,
                    dotBgColor: Colors.yellow[800].withOpacity(0.001),
                    dotSize: 6.0,
                    dotColor: Colors.white,
                    showIndicator: true,
                    dotPosition: DotPosition.bottomCenter,
                    images: [
                      RaisedButton(
                        onPressed: null,
                        child: Image.asset(images[0]),
                      ),
                      RaisedButton(
                        onPressed: null,
                        child: Image.asset(images[1]),
                      ),
                      RaisedButton(
                        onPressed: null,
                        child: Image.asset(images[2]),
                      )
                    ],
                    animationDuration: Duration(milliseconds: 1200),
                    dotVerticalPadding: 0,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 6,
                    child: Center(
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        alignment: WrapAlignment.center,
                        children: [
                          FlatButton(
                              onPressed: null,
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/tariicon.png'),
                                  Text(
                                    'Tarian',
                                    style: TextStyle(
                                        fontFamily: 'Mulish',
                                        color: Colors.white),
                                  )
                                ],
                              )),
                          FlatButton(
                              onPressed: null,
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/12345.png'),
                                  Text(
                                    'Alat Musik',
                                    style: TextStyle(
                                        fontFamily: 'Mulish',
                                        color: Colors.white),
                                  )
                                ],
                              )),
                          FlatButton(
                              onPressed: null,
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/wajan.png'),
                                  Text(
                                    'Memasak',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Mulish'),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kelas Rekomendasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return RecomendationItem(
                        rating: dataList[index].rating,
                        title: dataList[index].title,
                        description: dataList[index].description,
                        images: dataList[index].images,
                        id: dataList[index].id,
                        price: dataList[index].price,
                        author: dataList[index].instructor,
                        onPressed: dataList[index]);
                  },
                  itemCount: dataList.length,
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  padding: EdgeInsets.all(8.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kelas Tarian Daerah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return DanceItem(
                      rating: dataList2[index].rating,
                      title: dataList2[index].title,
                      description: dataList2[index].description,
                      images: dataList2[index].images,
                      id: dataList2[index].id,
                      price: dataList2[index].price,
                      author: dataList2[index].instructor,
                      onPressed: dataList2[index],
                    );
                  },
                  itemCount: dataList2.length,
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  padding: EdgeInsets.all(8.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
