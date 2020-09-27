import 'package:flutter/material.dart';
import 'package:zapihatalyoumnew/Bloc/side_menu_bloc.dart';
import 'package:zapihatalyoumnew/DataLayer/Menu.dart';
import 'package:zapihatalyoumnew/UI/Screens/my_account_screen.dart';

import '../../shared_data.dart';
import 'AboutUsScreen.dart';
import 'CartScreen.dart';
import 'ContactUsScreen.dart';
import 'OrdersScreen.dart';
import 'OurAccounts.dart';
import 'ProductsScreen.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final bloc = SideMenuBloc();
    return StreamBuilder(
        stream: bloc.menuStream,
        builder: (context, snapshot) {
          final menu = snapshot.data;
          return Container(
            child: Scaffold(
                backgroundColor: Colors.white,
                key: _scaffoldKey,
                endDrawer: Drawer(
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
                        height: 70,
                        width: 70,
                      ),
                      divider(),
                      rowSide(Menu(1), context, bloc, titles[0]),
                      rowSide(Menu(3), context, bloc, titles[2]),
                      rowSide(Menu(4), context, bloc, titles[3]),
                      rowSide(Menu(5), context, bloc, titles[4]),
                      rowSide(Menu(6), context, bloc, titles[5]),
                      rowSide(Menu(7), context, bloc, titles[6]),
                      rowSide(Menu(8), context, bloc, titles[7]),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(20, 40, 0, 0),
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
                              FlatButton(
                                onPressed: () {
                                  _scaffoldKey.currentState.openEndDrawer();
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
                            ],
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width / 2 - 50,
                            top: 40,
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image.asset('images/logo.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PageScreen(menu),
                  ],
                )),
          );
        });
  }

  Widget PageScreen(Menu menu) {
    if (menu == null) {
      return ProductsScreen();
    } else {
      switch (menu.index) {
        case 1:
          return ProductsScreen();

        case 3:
          return MyOrdersScreen();
        case 4:
          return CartScreen();
        case 5:
          return ContactUsScreen();
        case 6:
          return AboutUsScreen();
        case 8:
          return MyAccountScreen();
        case 7:
//          Share.share("   حمل تطبيق ذبيحة اليوم   $appUrl");
          break;
        default:
          {
            return ProductsScreen();
          }
      }
    }
  }

  Widget rowSide(Menu menu, context, SideMenuBloc bloc, String title) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        appBarTitle = title;
        bloc.selectMenu(menu);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.end,
            ),
          ),
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

  String appBarTitle = "ذبيحة اليوم";
  List<IconData> icons = [
    Icons.account_circle,
    Icons.select_all,
    Icons.account_balance,
    Icons.local_shipping,
    Icons.add_shopping_cart,
    Icons.contact_phone,
    Icons.group,
    Icons.share,
  ];
  List<String> titles = [
    "طلب ذبيحة",
    "حساباتنا",
    "طلباتي",
    "سلة المشتريات",
    "اتصل بنا",
    "من نحن",
    "شارك التطبيق",
    "تسجيل الدخول"
  ];
}
