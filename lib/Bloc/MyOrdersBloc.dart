import 'dart:async';
import 'package:zapihatalyoumapp/DataLayer/Orders.dart';
import 'package:zapihatalyoumapp/helpers/DBHelper.dart';
import '../shared_data.dart';
import 'bloc.dart';

class MyOrdersBloc implements Bloc {
  final _controller = StreamController<List<Order>>();
  Stream<List<Order>> get ordersDataStream => _controller.stream;
  Future<void> fetchOrdersData() async {
    final dataList =
        await DBHelper.getorderData('user_orders', sql_orders_query);
    List<Order> items = dataList
        .map((item) {
          print(item['key']);
          return Order(
              id: item['id'], price: item['price'], date: item['date']);
        })
        .toList()
        .reversed
        .toList();
    print("myorders$items");
    _controller.sink.add(items);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
