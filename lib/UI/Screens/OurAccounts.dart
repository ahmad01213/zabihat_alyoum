import 'package:flutter/material.dart';
import 'package:zapihatalyoumnew/shared_data.dart';

class OurAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildCartListItem();
  }

  Widget buildCartListItem() {
    return Container(
      height: 200,
      width: double.infinity,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.all(6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            "https://pbs.twimg.com/profile_images/1177208516572065793/s-dzr52z_400x400.jpg",
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("مصرف الراجحي",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("حساب رقم  :  465445234327647264",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
