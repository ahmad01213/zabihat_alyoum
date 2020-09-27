import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zapihatalyoumnew/shared_data.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final aboutus = pages.firstWhere((page) => page.type == 'about');
    return Container(
      margin: EdgeInsets.all(15),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height - 170,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Text(
          aboutus.text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
