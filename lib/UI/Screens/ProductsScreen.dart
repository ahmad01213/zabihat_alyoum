import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zapihatalyoumnew/Bloc/ProductsBloc.dart';
import 'package:zapihatalyoumnew/Bloc/bloc_provider.dart';
import 'package:zapihatalyoumnew/DataLayer/Product.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
as notif;
import 'package:zapihatalyoumnew/UI/widgets/ProductItem.dart';
import 'package:zapihatalyoumnew/shared_data.dart';
class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    readToken();
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),

      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 150,
        child: buildProductGride(context),
      ),
    );
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  readToken() async {
    final storage = new FlutterSecureStorage();
    token = await storage.read(key: "token");
    print('token$token');
  }

  var bloc ;

  Widget buildProductGride(context) {
   if(bloc == null) {
     bloc = ProductsQueryBloc();
     bloc.getProducts();}
    return BlocProvider<ProductsQueryBloc>(
      bloc: bloc,
      child: StreamBuilder<List<Product>>(
          stream: bloc.productStream,
          builder: (context, snapshot) {
            return productList == null
                ? Container()
                : GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: productList.length,
                    itemBuilder: (ctx, i) {
                      return ProductItem(
                        product: productList[i],
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 5/6,
                      mainAxisSpacing: 10,
                    ),
                  );
          }),
    );
  }
  @override
  void initState() {
    super.initState();
    readFireToken();
    flutterLocalNotificationsPlugin =
    new notif.FlutterLocalNotificationsPlugin();
    var android = new notif.AndroidInitializationSettings('@drawable/logo');
    var iOS = new notif.IOSInitializationSettings();
    var initSetttings = new notif.InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings);

    _firebaseMessaging.subscribeToTopic('zabihat_users');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showNotification(
            message['notification']['title'], message['notification']['body']);
      },
      onBackgroundMessage: null,
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  notif.FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  notif.FlutterLocalNotificationsPlugin();
  showNotification(title, body) async {
    var android = new notif.AndroidNotificationDetails(
        '65', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: notif.Priority.High, importance: notif.Importance.High);
    var iOS = new notif.IOSNotificationDetails();
    var platform = new notif.NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }
  readFireToken() async {
    firetoken = await _firebaseMessaging.getToken();
  }


}
