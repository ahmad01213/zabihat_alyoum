import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zapihatalyoumnew/shared_data.dart';
class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}
class MapScreenState extends State<MapScreen> {
  LatLng cameraLocation;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locationData.latitude, locationData.longitude),
    zoom: 19.151926040649414,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(locationData.latitude, locationData.longitude),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'حدد عنوان التوصيل',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onCameraMove: (pos) {
              cameraLocation = pos.target;
            },
            onCameraIdle: () {
              cameraLocation != null
                  ? print(cameraLocation.longitude)
                  : print("");
            },
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Center(
            child: Icon(
              Icons.place,
              color: Colors.red,
              size: 40,
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            child: Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: mainColor),
              child: MaterialButton(
                child: Text(
                  'تحديد هنا',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  mapLocation = cameraLocation;
                  print("maaaaap $cameraLocation");
//                  getLocationAdress();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: mainColor,
        onPressed: _goToTheLake,
        label: Text(''),
        icon: Icon(Icons.my_location),
      ),
    );
  }

//  Future<String> getLocationAdress() async {
//    try {
//      print("hoooy $mapLocation");
//      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
//          mapLocation.latitude, mapLocation.longitude);
//      final place = placemark[0];
//      final userAdress = place.thoroughfare +
//          "-" +
//          place.subLocality +
//          "-" +
//          place.locality +
//          "-" +
//          place.administrativeArea +
//          "-" +
//          place.country;
//      Navigator.pop(context, " ✔ " + userAdress);
//    } catch (exept) {
//      Navigator.pop(context, 'تم تحديد الموقع بنجاح ✔');
//    }
//  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
