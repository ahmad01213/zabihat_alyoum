import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:zapihatalyoumnew/DataLayer/Cart.dart';
import 'package:zapihatalyoumnew/helpers/DBHelper.dart';
import 'package:zapihatalyoumnew/shared_data.dart';
import 'bloc.dart';

class CartDataBloc implements Bloc {
  final _controller = StreamController<List<Cart>>();
  Stream<List<Cart>> get cartDataStream => _controller.stream;
  Future<void> fetchCartData() async {
    final dataList = await DBHelper.getData('user_cart', sql_cart_query);
    List<Cart> items = dataList.map((item) {
      print(item['key']);
      return Cart(
          name: item['name'],
          image: item['image'],
          cut_name: item['cut_name'],
          item_price: item['item_price'],
          key: item['key'],
          id: item['id'],
          pack: item['pack'],
          quantity: item['quantity'],
          size_key: item['size_key'],
          cut_key: item['cut_key'],
          size_name: item['size_name']);
    }).toList();
    counter = items.length;
    _controller.sink.add(items);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
