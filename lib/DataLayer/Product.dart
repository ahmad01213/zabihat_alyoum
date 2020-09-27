class Product {
  String id;
  String title;
  String description;
  String image;
  String smallerPrice;
  List<ProductSize> sizes;
  List<ProductCut> cuts;
  List<Productpack> packs;

  Product(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.smallerPrice,
      this.sizes,
        this.packs,
      this.cuts});
}

class ProductCut {
  String id;
  String name;
  ProductCut({this.id, this.name});
}
class Productpack {
  String id;
  String name;
  Productpack({this.id, this.name});
}
class ProductSize {
  String id;
  String name;
  String price;
  ProductSize({this.id, this.name, this.price});
}
