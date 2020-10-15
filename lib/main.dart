import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:launch_review/launch_review.dart';
import 'package:zapihatalyoumnew/UI/Screens/AboutUsScreen.dart';
import 'package:zapihatalyoumnew/UI/Screens/CartScreen.dart';
import 'package:zapihatalyoumnew/UI/Screens/ContactUsScreen.dart';
import 'package:zapihatalyoumnew/UI/Screens/MazadScreen.dart';
import 'package:zapihatalyoumnew/UI/Screens/NotificationsScreen.dart';
import 'package:zapihatalyoumnew/UI/Screens/OrdersScreen.dart';
import 'package:zapihatalyoumnew/UI/Screens/ProductsScreen.dart';
import 'package:zapihatalyoumnew/UI/Screens/my_account_screen.dart';
import 'package:zapihatalyoumnew/shared_data.dart';
import 'Bloc/bloc_provider.dart';
import 'Bloc/side_menu_bloc.dart';
import 'DataLayer/Menu.dart';
import 'helpers/MyHttpOverrides.dart';
void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MainWidget());
}
class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}
class _MainWidgetState extends State<MainWidget> {
  String appBarTitle = "ذبيحة اليوم";
  List<IconData> icons = [
    Icons.select_all,
    Icons.storage,
    Icons.account_balance,
    Icons.local_shipping,
    Icons.add_shopping_cart,
    Icons.contact_phone,
    Icons.group,
    Icons.share,
    Icons.notifications,
  ];
  List<String> titles = [
    "طلب ذبيحة",
    'المزاد',
    "طلباتي",
    "سلة المشتريات",
    "اتصل بنا",
    "من نحن",
    "قيم التطبيق",
    "حسابي",
    "الإشعارات"
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    getUserLocation();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: mainColor, //or set color with: Color(0xFF0000FF)
    ));
    final bloc = SideMenuBloc();
    return BlocProvider<SideMenuBloc>(
      bloc: bloc,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Locale('ar', 'AE'),
        theme: ThemeData(
          fontFamily: 'default',
          brightness: Brightness.light,
          primaryColor: mainColor,
          accentColor: mainColor,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
        ),
        home: StreamBuilder(
            stream: bloc.menuStream,
            builder: (context, snapshot) {
              final menu = snapshot.data;
              return Container(
                child: Scaffold(
                    resizeToAvoidBottomPadding: false,
                    backgroundColor: Colors.white,
                    key: _scaffoldKey,
                    drawer: Drawer(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Image.asset(
                              "images/logo.png",
                              fit: BoxFit.cover,
                            ),
                            height: 100,
                            width: 100,
                          ),
                          rowSide(Menu(1), context, bloc, titles[0]),
                          rowSide(Menu(2), context, bloc, titles[1]),
                          rowSide(Menu(3), context, bloc, titles[2]),
                          rowSide(Menu(4), context, bloc, titles[3]),
                          rowSide(Menu(5), context, bloc, titles[4]),
                          rowSide(Menu(6), context, bloc, titles[5]),
                          rowSide(Menu(7), context, bloc, titles[6]),
                          rowSide(Menu(8), context, bloc, titles[7]),
                          rowSide(Menu(9), context, bloc, titles[8]),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ), // assign key to Scaffoldq
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 140,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 85,
                                width: MediaQuery.of(context).size.width,
                                color: mainColor,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      _scaffoldKey.currentState.openDrawer();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 40, 0, 0),
                                    height: 35,
                                    width: 35,
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        bloc.selectMenu(Menu(4));
                                      },
                                      child: Image.asset(
                                        'images/cart.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                left:
                                    MediaQuery.of(context).size.width / 2 - 50,
                                top: 40,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset('images/logo.png'),
                                ),
                              ),
//                              Positioned(
//                                left: 50,
//                                top: 37,
//                                child: Container(
//                                  height: 17,
//                                  width: 17,
//                                  child: Image.asset(
//                                    'images/count.png',
//                                    width: 20,
//                                    height: 20,
//                                    fit: BoxFit.cover,
//                                  ),
//                                ),
//                              ),
//                              Positioned(
//                                left: 56,
//                                top: 39,
//                                child: Container(
//                                    height: 15,
//                                    width: 15,
//                                    child: Text(
//                                      counter.toString(),
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontSize: 10,
//                                          fontWeight: FontWeight.bold),
//                                    )),
//                              ),
                            ],
                          ),
                        ),
                        PageScreen(menu),
                      ],
                    )),
              );
            }),
      ),
    );
  }

  Widget PageScreen(Menu menu) {
    if (menu == null) {
      return ProductsScreen();
    } else {
      switch (menu.index) {
        case 1:
          return ProductsScreen();
        case 2:
          return MazadScreen();

        case 3:
          return MyOrdersScreen();
        case 4:
          return CartScreen();
        case 5:
          return ContactUsScreen();
        case 6:
          return AboutUsScreen();
        case 7:
          LaunchReview.launch(androidAppId: "com.aebrahima830.zapihatalyoum_app_android",
              iOSAppId: "585027354");
          return ProductsScreen();
          break;
        case 8:
          return MyAccountScreen();
        case 9:
          return NotificationsScreen();
        default:
          {
            return ProductsScreen();
          }
      }
    }
  }

  navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyAccountScreen(),
      ),
    );
  }

  Widget rowSide(Menu menu, context, SideMenuBloc bloc, String title) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        appBarTitle = title;
        bloc.selectMenu(menu);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
                width: 25,
                height: 25,
                child: Icon(
                  icons[menu.index - 1],
                  size: 25,
                  color: mainColor,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              titles[menu.index - 1],
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      indent: 20,
      endIndent: 20,
      height: 1,
      color: mainColor,
    );
  }
}
