import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zapihatalyoumapp/Bloc/DetailListBloc.dart';
import 'package:zapihatalyoumapp/Bloc/LocationBloc.dart';
import 'package:zapihatalyoumapp/Bloc/bloc_provider.dart';
import 'package:zapihatalyoumapp/Bloc/side_menu_bloc.dart';
import 'package:zapihatalyoumapp/DataLayer/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:zapihatalyoumapp/DataLayer/Location.dart';
import 'package:zapihatalyoumapp/DataLayer/Menu.dart';
import 'package:zapihatalyoumapp/UI/Screens/ProductDetailsScreen.dart';
import 'package:zapihatalyoumapp/helpers/DBHelper.dart';
import '../../shared_data.dart';
import 'MapScreen.dart';

class LocationScreen extends StatefulWidget {
  var detailContext;
  String completeCost;
  var cartData;
  bool isCartPage = true;

  LocationScreen(
      {this.cartData, this.completeCost, this.isCartPage, this.detailContext});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController phoneController = TextEditingController();
  LatLng selectedLocation;
  String address = userAdress;
  String mapAdress = ' اختر من الخريطة';

  @override
  Widget build(BuildContext context) {
    selectedPeriod = "الفترة الصباحية";
    selctedPayMent = "كاش (عند الإستلام)";
    selectedLocation = LatLng(locationData.latitude, locationData.longitude);
    final bloc = LocationBloc();
//    bloc.selectLocation(Location(mapAdress: mapAdress, isMyLocation: true));
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            "إكمال الطلب",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          centerTitle: true,
          backgroundColor: mainColor,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: Text(
                      ' رقم الهاتف',
                      style: TextStyle(
                        color: socondColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                    child: TextField(
                      focusNode: FocusNode(),
                      enabled: false,
                      controller: TextEditingController()..text = user.phone,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: Text(
                      'عنوان التوصيل',
                      style: TextStyle(
                        color: socondColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  BlocProvider<LocationBloc>(
                      bloc: bloc,
                      child: StreamBuilder<Location>(
                          stream: bloc.locationStream,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            print("mapAddress$mapAdress");
                            return Column(
                              children: <Widget>[
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          data == null ||
                                                  data.isMyLocation == false
                                              ? Icons.blur_circular
                                              : Icons.check_circle,
                                          size: 26,
                                          color: mainColor,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 40),
                                          child:
                                              Text('التوصيل الي عنوانك الحالي',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    bloc.selectLocation(Location(
                                        isMyLocation: true,
                                        mapAdress: mapAdress));
                                    selectedLocation = LatLng(
                                        locationData.latitude,
                                        locationData.longitude);
                                    address = userAdress;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black38,
                                            style: BorderStyle.solid,
                                            width: 1)),
                                    child: Text(userAdress,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          data == null ||
                                                  data.isMyLocation == true
                                              ? Icons.blur_circular
                                              : Icons.check_circle,
                                          size: 26,
                                          color: mainColor,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 40),
                                          child: Text('التوصيل الي عنوان اخر',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    bloc.selectLocation(Location(
                                        isMyLocation: false,
                                        mapAdress: mapAdress));
                                    address = mapAdress;
                                    selectedLocation = mapLocation;
                                  },
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.fromLTRB(20, 10, 40, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: mainColor),
                                  child: MaterialButton(
                                    child: Text(
                                      mapAdress.length > 30
                                          ? mapAdress.substring(0, 40)
                                          : mapAdress,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MapScreen(),
                                        ),
                                      ).then((result) {
                                        if (mapLocation != null) {
                                          print("not nullll$result");
                                          bloc.selectLocation(Location(
                                              isMyLocation: false,
                                              mapAdress: result != null
                                                  ? result
                                                  : ""));
                                          selectedLocation = mapLocation;
                                          mapAdress = result != null
                                              ? result
                                              : mapAdress;
                                        }
                                        print("mapAddress$mapAdress");
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          })),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Divider(
                      thickness: 0.5,
                      color: mainColor,
                    ),
                  ),
                  buildListTitle('  فترة التوصيل'),
                  buildList(periods, 3),
                  buildListTitle('  طريقة الدفع'),
                  buildList(payments, 4),
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: mainColor,
                      onPressed: () {
                        confirmOrder(context);
                      },
                      child: Text(
                        'إرسال الطلب',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      elevation: 8.0,
                      child: Container(
                        child: SpinKitDualRing(
                          color: mainColor,
                          size: 50,
                          lineWidth: 5,
                        ),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }

  Widget buildListTitle(String title) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.fromLTRB(18, 15, 20, 10),
      child: Text(
        title.trim(),
        style: TextStyle(
            fontSize: 20, color: socondColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildListItem(dynamic data, int index, icon, which, bloc) {
//    final bloc = DetailListBloc();
    return InkWell(
      onTap: () {
        saveDataSelected(data, which);
        bloc.setCount(index);
      },
      child: Container(
          height: 60,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buildListItemIcon(icon),
              buildlistItemTitle(data),
            ],
          )),
    );
  }

  String selectedPeriod;

  String selctedPayMent;

  void saveDataSelected(dynamic data, int whichList) {
    if (whichList == 3) {
      selectedPeriod = data;
    } else if (whichList == 4) {
      selctedPayMent = data;
    }
  }

  Widget buildlistItemTitle(title) {
    return Container(
      width: 250,
      padding: EdgeInsets.only(right: 20),
      alignment: Alignment.topRight,
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildListItemIcon(IconData icon) {
    return Icon(
      icon,
      color: mainColor,
      size: 25,
    );
  }

  var isloading = false;
  Future<void> confirmOrder(context) async {
    Map<String, dynamic> params = Map();
    print("json : ${widget.cartData}");
    params['payment_type'] = selctedPayMent;
    params['products'] = "${widget.cartData.toString()}";
    params['lat'] = selectedLocation.latitude.toString();
    params['lng'] = selectedLocation.longitude.toString();
    params['total_cost'] = widget.completeCost;
    params['selected_period'] = selectedPeriod;
    params['accepted'] = "0";
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    setState(() {
      isloading = true;
    });
    final uri = "https://thegradiant.com/zabihat_alyoum/api/useraddorder";

    final response = await http.post(
      uri,
      headers: isRegistered() ? headers : null,
      body: params,
    );
    print("response  :  ${response.statusCode}");
    setState(() {
      isloading = false;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "شكرا لك تم استلام طلبك بنجاح سيقوم مندوبتا بتوصيل طلبك في اسرع وقت ممكن",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            content: Text(""),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "حسنا",
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context, 'yes');
                },
              ),
            ],
          );
        });
    DBHelper.clearCart();
  }

  Widget buildList(List<dynamic> data, int whichList) {
    final bloc = DetailListBloc();
    return BlocProvider<DetailListBloc>(
      bloc: bloc,
      child: Container(
        width: double.infinity,
        height: data.length * 60.0 + 20,
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: StreamBuilder<int>(
                stream: bloc.countStream,
                builder: (context, snapshot) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (ctx, i) {
                        final icon = snapshot.data != null && snapshot.data == i
                            ? Icons.check_circle
                            : Icons.blur_circular;
                        print('${snapshot.data} heyyy $i');
                        return buildListItem(data[i], i, icon, whichList, bloc);
                      });
                })),
      ),
    );
  }

  Future<void> showSuccessDialog(context, newCount) async {
    clearCart();
    notifyAdmin();
    DBHelper.insertorder(
        'user_orders',
        {
          'id': newCount.toString(),
          'price': widget.completeCost.toString(),
          'date': new DateTime.now().toString()
        },
        sql_orders_query);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'رقم الطلب  $newCount',
          style: TextStyle(
              color: mainColor, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.end,
        ),
        content: Text(
          "شكرا لك .. تم استلام طلبكم بنجاح , وسيتم التواصل معكم في أقرب وقت ممكن ",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'حسنا',
              textAlign: TextAlign.end,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              if (widget.isCartPage == false) {
                ProductDetailsScreen.closePage(widget.detailContext);
              }
              final bloc = BlocProvider.of<SideMenuBloc>(context);
              bloc.selectMenu(Menu(3));
            },
          )
        ],
      ),
    );
  }

  Future<void> notifyAdmin() async {
    final url = "https://fcm.googleapis.com/fcm/send";
    final response = await http.post(url,
        headers: {
          "Authorization":
              "key=AAAA3srvG0k:APA91bGUrzEfYlArAAMp8KoAkrM1vwNzrA65dNgZSVCFaVxONyaCKtpuY_LT988SZzSJhW2-73dYcP5LHh5gmB4ABJlr3RJCJnNtDBbbajDeFL28OsLBTSGZW6Mo9OYoRVE1TpRhijaK",
          "Content-Type": "application/json"
        },
        body: json.encode({
          "to": "/topics/zabaeh_el_riad",
          "notification": {
            "title": "مدير الطلبات",
            "body": "لديكم طلب جديد",
            "mutable_content": true,
            "sound": "alarm"
          }
        }));
  }

  void clearCart() {
    DBHelper.clearCart();
  }
}
