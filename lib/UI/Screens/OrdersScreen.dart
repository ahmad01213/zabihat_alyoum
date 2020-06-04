import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapihatalyoumapp/Bloc/MyOrdersBloc.dart';
import 'package:zapihatalyoumapp/Bloc/bloc_provider.dart';
import 'package:zapihatalyoumapp/DataLayer/Orders.dart';

import '../../shared_data.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = MyOrdersBloc();
    bloc.fetchOrdersData();

    return Center(
        child: Container(
            height: MediaQuery.of(context).size.height - 140,
            child: BlocProvider(
                bloc: bloc,
                child: StreamBuilder<List<Order>>(
                    stream: bloc.ordersDataStream,
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? buildList(snapshot.data)
                          : buildList([]);
                    }))));
  }

  Widget buildList(List<Order> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (ctx, i) {
          return buildListItem(data[i]);
        });
  }

  Widget buildListItem(Order order) {
    return Container(
      height: 250,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    order.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      "رقم الطلب",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: socondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    order.price + "  R.S",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      "إجمالي السعر",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: socondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      order.date,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      "توقيت الطلب",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: socondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget DataRow(name, value) {
    return Row(
      children: <Widget>[],
    );
  }
}
