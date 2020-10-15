import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zapihatalyoumnew/DataLayer/Notif.dart';
import 'package:zapihatalyoumnew/UI/Screens/MazadConfirm.dart';
import 'package:zapihatalyoumnew/shared_data.dart';
import 'package:http/http.dart' as http;

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isloading
          ? Center(
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
            )
          :isRegistered()? ListView.builder(
              itemBuilder: (ctx, i) {
                Notif notification = notifs[i];
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 10.0),
                        blurRadius: 10.0)
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.date,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        notification.title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: mainColor),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        notification.body,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      notification.type != 'none'
                          ? Container(
                              height: 40,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      color: mainColor,
                                      style: BorderStyle.solid,
                                      width: 1)),
                              child: MaterialButton(
                                child: Text(
                                  'اضغط هنا لإرسال العنوان والتفاصبل',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MazadConfirm(
                                        isCartPage: false,
                                       onCnfirm:getUserNotifications,
                                       detailContext: context,
                                        bidId: notification.type,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
              itemCount: notifs.length,
              physics: BouncingScrollPhysics(),
            ):Center(child: Text('الرجاء تسجيل الدخول'),),
    );
  }

  bool isloading = false;
  List<Notif> notifs=[];

  getUserNotifications() async {
    final url = 'https://www.appweb.host/zabihat_alyoum/api/usernotifications';
    final headers = {"Authorization": "Bearer " + token};
    print("url  :  $url");
    setState(() {
      isloading = true;
    });
    final response = await http.post(url, headers: headers);
    notifs.clear();
    print("ressss : ${response.body}");
    final ordersJson = json.decode(response.body) as List<dynamic>;
    ordersJson.forEach((notif){
      notifs.add(Notif.fromJson(notif));
    });
    notifs = notifs.reversed.toList();
    setState(() {
      isloading = false;
    });
  }


  @override
  void initState() {
    getUserNotifications();
    super.initState();
  }
}
