import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapihatalyoumapp/Bloc/CartDataBloc.dart';
import 'package:zapihatalyoumapp/Bloc/bloc_provider.dart';
import 'package:zapihatalyoumapp/Bloc/side_menu_bloc.dart';
import 'package:zapihatalyoumapp/DataLayer/Cart.dart';
import 'package:zapihatalyoumapp/DataLayer/Menu.dart';
import 'package:zapihatalyoumapp/UI/Screens/LocationScreen.dart';
import 'package:zapihatalyoumapp/helpers/DBHelper.dart';
import 'package:zapihatalyoumapp/shared_data.dart';

class CartScreen extends StatelessWidget {
  double totalCost = 0.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 140,
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: buildCartList(),
      ),
    );
  }

  List<Cart> data;
  Widget buildCartList() {
    final bloc = CartDataBloc();
    bloc.fetchCartData();
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder<List<Cart>>(
          stream: bloc.cartDataStream,
          builder: (context, snapshot) {
            data = snapshot.data;
            if (data != null) totalCost = 0.0;
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (ctx, i) {
                        print('total stream $totalCost');
                        return buildCartListItem(data[i], bloc, context);
                      }),
                ),
                Positioned(
                  child: buildBottomView(data, context),
                  left: 0,
                  right: 0,
                  bottom: 0,
                )
              ],
            );
          }),
    );
  }

  Widget buildCartListItem(Cart data, bloc, context) {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: CachedNetworkImage(
                            imageUrl: data.image,
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(data.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            )),
                        buildQuantityInputs(data, bloc),
                      ],
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.only(left: 10),
                    child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          DBHelper.delete(
                              'user_cart', data.key, sql_cart_query);
                          print('detail${data.key}');
                          bloc.fetchCartData();
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "الحجم  :  ${data.size_name}  -  ${data.item_price}   ريال",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: data.size_name.length > 18 ? 10 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "التقطيع  :  ${data.cut_name}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuantityInputs(Cart data, CartDataBloc bloc) {
    return Container(
      height: 30,
      width: 130,
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  DBHelper.update(
                      'user_cart',
                      data.key,
                      int.parse(data.quantity) > 1
                          ? (int.parse(data.quantity) - 1).toString()
                          : 1.toString(),
                      sql_cart_query);
                  bloc.fetchCartData();
                },
                child: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                  size: 30,
                )),
          ),
          Text(
            data.quantity,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Container(
            width: 30,
            height: 30,
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  DBHelper.update(
                      'user_cart',
                      data.key,
                      (int.parse(data.quantity) + 1).toString(),
                      sql_cart_query);
                  bloc.fetchCartData();
                },
                child: Icon(
                  Icons.add_circle_outline,
                  color: mainColor,
                  size: 30,
                )),
          )
        ],
      ),
    );
  }

  Widget buildBottomView(List<Cart> data, context) {
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        final cost =
            int.parse(data[i].quantity) * double.parse(data[i].item_price);
        totalCost = totalCost + cost;
      }
    }
    print('total bottom $totalCost');
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 10),
            child: data != null && data.length > 0
                ? Text('السعر  $totalCost ريال ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ))
                : Container(),
          ),
          Container(
            child: data != null && data.length > 0
                ? footer(context)
                : Center(
                    child: Text(
                    'السلة فارغة',
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            height: 60,
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget footer(context) => Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: mainColor, style: BorderStyle.solid, width: 1)),
                child: MaterialButton(
                  child: Text(
                    'أضف المزيد',
                    style: TextStyle(
                        color: mainColor, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final bloc = BlocProvider.of<SideMenuBloc>(context);
                    bloc.selectMenu(Menu(1));
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                color: mainColor,
                child: MaterialButton(
                  child: Text(
                    'تنفيذ الطلب',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    isRegistered()
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationScreen(
                                isCartPage: false,
                                detailContext: context,
                                cartData: Cart.encondeToJson(data),
                                completeCost: totalCost.toString(),
                              ),
                            ),
                          )
                        : alert("الرجاء تسجبل الدخول", context);
                  },
                ),
              ),
            ),
          ),
        ],
      );
  alert(message, ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            content: Text(""),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "حسنا",
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
