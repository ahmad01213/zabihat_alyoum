import 'package:flutter/material.dart';
import 'package:zapihatalyoumapp/shared_data.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.only(left: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(bank[1],
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            bank[0],
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("حساب رقم  :  ${bank[2]}",
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
