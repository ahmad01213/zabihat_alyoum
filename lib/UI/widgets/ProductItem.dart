import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapihatalyoumnew/DataLayer/Product.dart';
import 'package:zapihatalyoumnew/UI/Screens/ProductDetailsScreen.dart';
import 'package:zapihatalyoumnew/shared_data.dart';

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem({this.product});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return ProductDetailsScreen(
                product: product,
              );
            },
          ),
        );
      },
      child: Container(
        child: Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            fit: BoxFit.fill,
                            height: 155,
                          ),
                        )),
                    Positioned(
                        left: 0,
                        bottom: 16,
                        right: 0,
                        child: Image.asset(
                          'images/green2.png',
                          fit: BoxFit.fill,
                          height: 50,
                        )),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              color: Color(0xFF81000000),
                              height: 45,
                            ))),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 120,
                          child: Text(
                            product.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 130,
                height: 25,
                child: Text(
                  ' يبدأ من  ${product.smallerPrice} ريال  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
