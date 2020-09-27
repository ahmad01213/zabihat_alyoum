import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:zapihatalyoumnew/DataLayer/Pag.dart';
import 'package:zapihatalyoumnew/shared_data.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "تواصل معنا",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: socondColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 100,
            width: 100,
            child: InkWell(
              onTap: () {
                Pag $phoneNum =
                    pages.firstWhere((page) => page.type == 'phone');
                UrlLauncher.launch("tel://${$phoneNum.text}");
              },
              child: Card(
                color: mainColor,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Icon(
                  Icons.call,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            "عبر الإتصال",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 100,
            width: 100,
            child: InkWell(
              onTap: () {
                Pag $phoneNum =
                    pages.firstWhere((page) => page.type == 'whats');
                String whatsAppUrl =
                    "https://api.whatsapp.com/send?phone=${$phoneNum.text}";
                UrlLauncher.launch(whatsAppUrl);
              },
              child: Card(
                color: mainColor,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Icon(
                  Icons.chat,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            "عبر الواتس أب",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
    );
  }
}
