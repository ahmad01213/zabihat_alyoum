import 'dart:async';
import 'package:zapihatalyoumnew/DataLayer/Menu.dart';
import 'bloc.dart';

class SideMenuBloc extends Bloc {
  Menu _menu;
  Menu get selectedMenu => _menu;
  // 1
  final _menuController = StreamController<Menu>();
  // 2
  Stream<Menu> get menuStream => _menuController.stream;
  // 3
  void selectMenu(Menu menu) {
    _menu = menu;
    _menuController.sink.add(menu);
  }

  // 4
  @override
  void dispose() {
    _menuController.close();
  }
}
