class Product {
  String id;
  String title;
  String description;
  String image;
  String smallerPrice;
  List<ProductSize> sizes;
//  List<ProductCut> cut;

  Product({
    this.id,
    this.title,
    this.description,
    this.image,
    this.smallerPrice,
    this.sizes,
  });
}

class ProductSize {
  String id;
  String name;
  String price;
  ProductSize({this.id, this.name, this.price});
}
