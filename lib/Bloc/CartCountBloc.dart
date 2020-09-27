import 'dart:async';
import 'package:zapihatalyoumnew/helpers/DBHelper.dart';

import '../shared_data.dart';
import 'bloc.dart';

class CartCountBloc extends Bloc {
  int _count;
  int get selectedMenu => _count;
  // 1
  final _countController = StreamController<int>();
  // 2
  Stream<int> get countStream => _countController.stream;
  Future<void> fetchCartData() async {
    final dataList = await DBHelper.getData('user_cart', sql_cart_query);
    var items = dataList.map((item) {}).toList();
    items != null
        ? _countController.sink.add(items.length)
        : _countController.sink.add(0);
  }

  // 4
  @override
  void dispose() {
    _countController.close();
  }
}



