class Menu {
  int _index = 0;

  int get index => _index;

  set index(int value) {
    _index = value;
  }

  Menu(this._index);
}
