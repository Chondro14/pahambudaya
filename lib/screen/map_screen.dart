import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pahambudaya/widget/item_searching.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  double latitude;
  double longitude;
  Positioned position;
  BitmapDescriptor mylocationpin;
  BitmapDescriptor pinSanggar;

  Future<void> _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
    setState(() {
      markers.add(Marker(
          markerId: MarkerId('<MARKER_ID>'),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          icon: mylocationpin));
    });
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-8.577402, 114.072169),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void setCustomPin() async {
    mylocationpin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/mylocation.png");
  }

  void setSanggarPin() async {
    pinSanggar = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/pinsanggar.png");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentLocation();
    setCustomPin();
    setSanggarPin();
  }

  // 1

// 2
  static final CameraPosition _myLocation = CameraPosition(
    target: LatLng(0, 0),
  );

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panel: Container(),
      body: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _myLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                setState(() {
                  markers.add(Marker(
                      markerId: MarkerId('<Sanggar1>'),
                      icon: pinSanggar,
                      position: LatLng(-8.551340, 114.112017)));
                  markers.add(Marker(
                      markerId: MarkerId('<Sanggar2>'),
                      icon: pinSanggar,
                      position: LatLng(-8.572806, 114.098221)));
                });
              },
              markers: markers,
              mapType: MapType.normal,
            ),
            Transform.translate(
              offset: Offset(0, 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 32.0, top: 8.0, right: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(0, 9),
                                blurRadius: 6,
                                spreadRadius: 8)
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Cari...",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                        child: ItemSearching())
                  ],
                ),
                color: Colors.white.withOpacity(0.001),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _currentLocation();
          },
          child: Icon(
            Icons.my_location,
            size: 30,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      ),
    );
  }
}
