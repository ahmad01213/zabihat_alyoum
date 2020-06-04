import 'dart:async';
import 'dart:convert';
import 'package:zapihatalyoumapp/DataLayer/Product.dart';
import 'package:http/http.dart' as http;
import 'package:zapihatalyoumapp/DataLayer/cuts.dart';
import '../shared_data.dart';
import 'bloc.dart';

class ProductsQueryBloc implements Bloc {
  final _controller = StreamController<List<Product>>();
  Stream<List<Product>> get productStream => _controller.stream;
  void getProducts() async {
    if (productList == null) {
      List<Product> resaults = [];
      bank = [];
      final url = "https://zabaeh-el-riad.firebaseio.com/products.json";
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      aboutUs = extractedData['about'];
      aboutImage = extractedData['imageabout'];
      phone = extractedData['phone'];
      bank.add(extractedData['accountimage']);
      bank.add(extractedData['accountname']);
      bank.add(extractedData['accountnumber']);
      whats = extractedData['whats'];
      appUrl = extractedData['appUrl'];
      if (extractedData == null) {
        return;
      }
      periods = [];
      print(extractedData);
      extractedData['periods'].forEach((periodsData) {
        periods.add(periodsData['name']);
      });
      print("periods $periods");
      print('itemss : ${extractedData["item"]}');
      cuts = [];
      extractedData['cuting'].forEach((cuttingData) {
        final cut = Cut(
          id: cuttingData['key'].toString(),
          name: cuttingData['name'],
        );
        cuts.add(cut);
      });
      print("cuttings $cuts");
      extractedData['item'].forEach((productData) {
        List<ProductSize> sizes = [];
        productData['size'].forEach((sizeData) {
          final size = ProductSize(
              id: sizeData['key'].toString(),
              name: sizeData['name'],
              price: sizeData['price']);
          sizes.add(size);
        });
        resaults.add(Product(
            sizes: sizes,
            id: productData['key'].toString(),
            title: productData['name'],
            description: productData['details'],
            image: productData['image'],
            smallerPrice: sizes[0].price));
        productList = resaults;
        _controller.sink.add(resaults);
      });
    } else {
      _controller.sink.add(productList);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
