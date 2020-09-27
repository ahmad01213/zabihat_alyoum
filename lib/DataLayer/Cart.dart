class Cart {
  String key;
  String id;
  String name;
  String pack;
  String quantity;
  String size_key;
  String size_name;
  String item_price;
  String cut_name;
  String cut_key;
  String image;
  Cart(
      {this.key,
        this.name, this.id,
      this.quantity,
      this.size_key,
      this.size_name,
      this.item_price,
      this.cut_name,
      this.image,
       this.pack,
      this.cut_key});
  toJson() {
    return "\{\"quantity\"\: ${this.quantity},\"productId\"\: ${this.id},\"size\"\: \"${this.size_name}\",\"cut\"\: \"${this.cut_name}\",\"pack\"\: \"${this.pack}\",\"price\"\: ${this.item_price}\}";
  }

  static List encondeToJson(List<Cart> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }
}
