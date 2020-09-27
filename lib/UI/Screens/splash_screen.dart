import 'package:flutter/material.dart';
import 'package:zapihatalyoumnew/Bloc/ProductsBloc.dart';
import 'package:zapihatalyoumnew/Bloc/side_menu_bloc.dart';
import 'package:zapihatalyoumnew/UI/Screens/ProductsScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.fromLTRB(0, 50, 0, 40),
          child: Image.asset(
            "images/logo.png",
            fit: BoxFit.cover,
          ),
          height: 130,
          width: 130,
        ),
      ),
    );
  }
}
