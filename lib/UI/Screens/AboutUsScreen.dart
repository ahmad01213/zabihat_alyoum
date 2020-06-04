import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zapihatalyoumapp/shared_data.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("about_us$aboutUs");
    return Container(
        height: MediaQuery.of(context).size.height - 150,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: CachedNetworkImage(
                imageUrl: aboutImage,
                fit: BoxFit.cover,
                height: 150,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: 100,
              left: 30,
              right: 30,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.8,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Center(
                    child: Text(
                      aboutUs,
                      style: TextStyle(
                          color: mainColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
