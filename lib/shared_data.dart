import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:zapihatalyoumnew/DataLayer/Pag.dart';
import 'package:zapihatalyoumnew/DataLayer/Product.dart';
import 'DataLayer/User.dart';
import 'DataLayer/cuts.dart';

List bank = [];
List<String> periods = [];
List<Pag> pages = [];
List<String> payments = ["كاش ( عند الإستلام )", "التحويل البنكي"];
LocationData locationData;
String userAdress;
LatLng mapLocation;
int counter = 0;
List<Product> productList;
String aboutImage =
    "https://alzbai7.yourtourticket.com/public/assets/image/items/PBO0APzi1WM737F43Fp7w1580124647.jpeg";
String phone = "054356446474";
String whats = "6347553";
String aboutUs = "fgdgfdgfkdfkjsfdjhdfjhdfhjdfsjhdfsjhf";
String appUrl = "";
String firetoken = "";
User user;
List mazads = [];
String token;
isRegistered()  {

  if (token != null) {
    return true;
  } else {
    return false;
  }
}

final sql_cart_query =
    'CREATE TABLE user_cart(id TEXT PRIMARY KEY , key TEXT, name TEXT,quantity TEXT, size_key TEXT,size_name TEXT,pack TEXT, item_price TEXT, price TEXT,cut_key TEXT, cut_name TEXT,image TEXT)';
final sql_orders_query =
    'CREATE TABLE user_orders(id TEXT PRIMARY KEY , price TEXT,date TEXT)';
Color mainColor = Color(0xFFF79F1F);
Color socondColor = Color(0xFFF79F1F);
//get currentLocationا
Future<void> getUserLocation() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();
  List<Placemark> placemark = await Geolocator()
      .placemarkFromCoordinates(locationData.latitude, locationData.longitude);
  final place = placemark[0];
  userAdress = place.thoroughfare +
      "-" +
      place.subLocality +
      "-" +
      place.locality +
      "-" +
      place.administrativeArea +
      "-" +
      place.country;
}
