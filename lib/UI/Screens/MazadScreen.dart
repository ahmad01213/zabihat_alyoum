import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zapihatalyoumnew/Bloc/ProductsBloc.dart';
import 'package:zapihatalyoumnew/Bloc/bloc_provider.dart';
import 'package:zapihatalyoumnew/DataLayer/Mazad.dart';
import 'package:zapihatalyoumnew/DataLayer/Product.dart';
import '../../shared_data.dart';
import 'package:http/http.dart' as http;

import 'my_account_screen_page.dart';

class MazadScreen extends StatefulWidget {
  @override
  _MazadScreenState createState() => _MazadScreenState();
}

class _MazadScreenState extends State<MazadScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsQueryBloc>(
      bloc: bloc,
      child: StreamBuilder<List<Product>>(
          stream: bloc.productStream,
          builder: (context, snapshot) {
            snapshot.data == null ? isloading = true : false;
            return buildOffersList(context);
          }),
    );
  }
  DateTime currentDate = DateTime.now();
  bool isloading = false;
  String difference = "";
  final bloc = ProductsQueryBloc();

  calculateRemainningTime(String endDate) {}
  Widget buildCartListItem(Mazad offer, context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      height: 240,
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          side: new BorderSide(color: mainColor, width: 0.5),
        ),
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: double.infinity,
                width: 170,
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        imageUrl: offer.image, fit: BoxFit.fill)),
              ),
              Container(
                color: mainColor,
                height: double.infinity,
                width: 1,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: Text(
                                offer.name,
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "اخر سعر",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${offer.minprice}   ريال",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              "الوقت المتبقي",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "${currentDate.difference(DateTime.parse(offer.endttime)).inHours}  س ",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: mainColor,
                                style: BorderStyle.solid,
                                width: 1)),
                        child: MaterialButton(
                          child: Text(
                            'أضف عرضك الان',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            isRegistered()
                                ? showDialog(
                                    context: context,
                                    child: addBidDialog(
                                        offer.id, offer.minprice, context))
                                : alert("الرجاء تسجبل الدخول", context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addBid(mazadId, bid, ctx) async {
    Navigator.of(ctx).pop();
    showDialog(
        context: ctx,
        builder: (context) {
          return SizedBox(
            height: 100,
            width: 100,
            child: AlertDialog(
              title: loading(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          );
        });
    Map<String, dynamic> params = Map();
    params['bid'] = bid;
    params['mazad_id'] = mazadId;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final uri = "https://www.appweb.host/zabihat_alyoum/api/mazads/addbid";
    final response = await http.post(
      uri,
      headers: isRegistered() ? headers : null,
      body: params,
    );
    productList = null;
    bloc.getProducts();
    print("object$response");
    Navigator.of(ctx).pop();
    alert("شكرا لك تمت اضافة عرضك بنجاح", ctx);
  }

  Widget loading() {
    return Center(
      child: Container(
        child: SpinKitRing(
          duration: Duration(milliseconds: 500),
          color: mainColor,
          size: 40,
          lineWidth: 5,
        ),
        width: 100,
        height: 100,
      ),
    );
  }

  Widget addBidDialog(mazadId, minprice, context) {
    String bid = "";
    return new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Row(
                children: <Widget>[
                  new Container(
                    // padding: new EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: new Text(
                      'أقل سعر $minprice  ريال  ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            // dialog centre
            new Expanded(
              child: new Container(
                  child: new TextField(
                onChanged: (v) {
                  bid = v;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'اكتب السعر'),
              )),
              flex: 2,
            ),

            // dialog bottom
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                decoration: new BoxDecoration(
                  color: mainColor,
                ),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    if(double.parse(bid.toString())>double.parse(minprice)){
                      addBid(mazadId, bid, context);
                    }else{
                      showSnackBar('أقل سعر $minprice  ريال  ');
                    }
                  },
                  child: new Text(
                    'إضافة',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  alert(message, ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            content: Text(""),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyAccountScreenPage(status:false )
                    ),
                  );
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  "إنشاء حساب",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyAccountScreenPage(status: true)
                    ),
                  );
                  Navigator.of(context).pop();

                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    productList = null;
    bloc.getProducts();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(message) {
    scaffoldKey?.currentState?.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget buildOffersList(context) {
    return Container(
      height: 500,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),

          itemCount: mazads.length,
          itemBuilder: (ctx, i) {
            return buildCartListItem(mazads[i], context);
          }),
    );
  }
}
