import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zapihatalyoumapp/DataLayer/Bid.dart';
import 'package:zapihatalyoumapp/DataLayer/Mazad.dart';
import 'package:zapihatalyoumapp/DataLayer/Pag.dart';
import 'package:zapihatalyoumapp/DataLayer/Product.dart';
import 'package:http/http.dart' as http;
import 'package:zapihatalyoumapp/DataLayer/User.dart';
import '../shared_data.dart';
import 'bloc.dart';

class ProductsQueryBloc implements Bloc {
  readToken() async {
    final storage = new FlutterSecureStorage();
    token = await storage.read(key: "token");
    print('token$token');
  }

  final _controller = StreamController<List<Product>>();

  Stream<List<Product>> get productStream => _controller.stream;

  void getProducts() async {
    readToken();
    if (productList == null) {
      final headers =
          isRegistered() ? {"Authorization": "Bearer " + token} : null;
      List<Product> resaults = [];
      bank = [];
      final url = "https://thegradiant.com/zabihat_alyoum/api/products";
      final response = await http.post(url, headers: headers);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      periods = [];
      pages = [];
      print(extractedData);
      extractedData['periods'].forEach((periodsData) {
        periods.add(periodsData['name']);
      });
      extractedData['mazads'].forEach((mazad) {
        List<Bid> bids = [];
        extractedData['mazads'][0]['bids'].forEach((bid) {
          bids.add(Bid(
              name: bid['user_name'],
              bid: bid['bid'],
              created_at: bid['created_at']));
        });
        mazads = [];
        mazads.add(Mazad(
            image: mazad['image'],
            name: mazad['name'],
            bids: bids,
            id: mazad['id'].toString(),
            desc: mazad['desc'],
            endttime: mazad['endtime'],
            starttime: mazad['starttime'],
            minprice: mazad['minprice'].toString()));
        print('mazads${mazads.length}');
      });
      extractedData['pages'].forEach((page) {
        pages.add(Pag(text: page['text'], type: page['type']));
      });
      if (isRegistered()) {
        user = User(
            name: extractedData['user_details']['name'],
            phone: extractedData['user_details']['phone']);
      }
      extractedData['products'].forEach((productData) {
        List<ProductSize> sizes = [];
        productData['sizes'].forEach((sizeData) {
          final size = ProductSize(
              id: sizeData['id'].toString(),
              name: sizeData['name'],
              price: sizeData['price']);
          sizes.add(size);
        });
        List<ProductCut> cuts = [];
        productData['cuts'].forEach((sizeData) {
          final cut =
              ProductCut(id: sizeData['id'].toString(), name: sizeData['cut']);
          cuts.add(cut);
        });
        resaults.add(Product(
            id: productData['id'].toString(),
            image: productData['image'],
            title: productData['name'],
            description: productData['desc'],
            cuts: cuts,
            sizes: sizes,
            smallerPrice: sizes[0].price));
        productList = resaults;
        _controller.sink.add(resaults);
      });
    } else {
      _controller.sink.add(productList);
    }
  }

  removeToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(
      key: 'token',
    );
    token = null;
  }

  @override
  void dispose() {
    _controller.close();
  }
}
