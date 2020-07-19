class Cart {
  String key;
  String name;
  String quantity;
  String size_key;
  String size_name;
  String item_price;
  String cut_name;
  String cut_key;
  String image;

  Cart(
      {this.key,
      this.name,
      this.quantity,
      this.size_key,
      this.size_name,
      this.item_price,
      this.cut_name,
      this.image,
      this.cut_key});

  toJson() {
    return "\{\"quantity\"\: ${this.quantity},\"productId\"\: ${this.key},\"size_id\"\: ${this.size_key},\"cut_id\"\: ${this.cut_key}\}";
  }

  static List encondeToJson(List<Cart> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }
}
