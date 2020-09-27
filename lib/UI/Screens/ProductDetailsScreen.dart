import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapihatalyoumnew/Bloc/DetailListBloc.dart';
import 'package:zapihatalyoumnew/Bloc/DetailQuantityBloc.dart';
import 'package:zapihatalyoumnew/Bloc/bloc_provider.dart';
import 'package:zapihatalyoumnew/Bloc/side_menu_bloc.dart';
import 'package:zapihatalyoumnew/DataLayer/Cart.dart';
import 'package:zapihatalyoumnew/DataLayer/Menu.dart';
import 'package:zapihatalyoumnew/DataLayer/Product.dart';
import 'package:zapihatalyoumnew/helpers/DBHelper.dart';
import 'package:zapihatalyoumnew/shared_data.dart';
import 'LocationScreen.dart';
class ProductDetailsScreen extends StatelessWidget {
  List<int> listModel = [0, 0, 0, 0];
  Product product;
  int count = 1;
  String selectedSize;
  String selectedPack;
  String slectedCut;
  String itemPrice;
  ProductDetailsScreen({this.product});
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            buildHeader(context),
            buildListTitle('اختر الحجم'),
            buildList(product.sizes, 1),
            buildListTitle('اختر التقطيع'),
            buildList(product.cuts, 2),
            buildListTitle('اختر التغليف'),
            buildList(product.packs, 3),
            buildListTitle('الكمية'),
            buildQuantityInputs(),
            buildButton(context)
          ],
        ),
      ),
    );
  }

  Widget buildHeader(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              width: 250,
              height: 150,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.fill,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                product.description,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItemIcon(IconData icon) {
    return Icon(
      icon,
      color: mainColor,
      size: 25,
    );
  }

  Widget buildlistItemTitle(title) {
    return Container(
      width: 250,
      padding: EdgeInsets.only(right: 20),
      alignment: Alignment.topRight,
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildListTitle(String title) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.fromLTRB(18, 15, 20, 10),
      child: Text(
        title.trim(),
        style: TextStyle(
            fontSize: 20, color: socondColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildList(List<dynamic> data, int whichList) {
    final bloc = DetailListBloc();
    return BlocProvider<DetailListBloc>(
      bloc: bloc,
      child: Container(
        width: double.infinity,
        height: data.length * 60.0 + 20,
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: StreamBuilder<int>(
                stream: bloc.countStream,
                builder: (context, snapshot) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (ctx, i) {
                        final icon = snapshot.data != null && snapshot.data == i
                            ? Icons.check_circle
                            : Icons.blur_circular;
                        print('${snapshot.data} heyyy $i');
                        return buildListItem(data[i], i, icon, whichList, bloc);
                      });
                })),
      ),
    );
  }

  Widget buildListItem(dynamic data, int index, icon, which, bloc) {
//    final bloc = DetailListBloc();
    return InkWell(
      onTap: () {
        saveDataSelected(data, which);
        print('size: ${data.id}');
        bloc.setCount(index);
      },
      child: Container(
          height: 60,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buildListItemIcon(icon),
              buildlistItemTitle(which == 1
                  ? data.name + "  -  " + data.price + "    ريال"
                  : data.name),
            ],
          )),
    );
  }

  void saveDataSelected(dynamic data, int whichList) {
    if (whichList == 1) {
      selectedSize = data.id;
    } else if (whichList == 2) {
      slectedCut = data.id;
    }else if (whichList == 3) {
      selectedPack = data.name;
    }
  }

  Widget buildQuantityInputs() {
    final bloc = DetailQuantityBloc();
    return Card(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                count > 1 ? bloc.setCount(count - 1) : print("");
              },
              child: Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
                size: 35,
              ),
            ),
            BlocProvider<DetailQuantityBloc>(
              bloc: bloc,
              child: StreamBuilder<int>(
                  stream: bloc.countStream,
                  builder: (context, snapshot) {
                    count = snapshot.data == null ? 1 : snapshot.data;
                    return Text(
                      count.toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    );
                  }),
            ),
            FlatButton(
              onPressed: () {
                bloc.setCount(count + 1);
              },
              child: Icon(
                Icons.add_circle_outline,
                color: mainColor,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(context) {
    return Container(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: mainColor, style: BorderStyle.solid, width: 1)),
                child: MaterialButton(
                  child: Text(
                    'أضف الي العربة',
                    style: TextStyle(
                        color: mainColor, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final validationMessage = validateInputs();
                    if (validationMessage == "") {
                      addProductToCart();
                      showSnackBar("تمت الاضافة الي العربة");
                      Navighttps://github.com/Purus/launch_reviewator.of(context).pop();
                      final bloc = BlocProvider.of<SideMenuBloc>(context);
                      bloc.selectMenu(Menu(4));
                    } else {
                      showSnackBar(validationMessage);
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                color: mainColor,
                child: MaterialButton(
                  child: Text(
                    'اطلب الان',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    orderNow(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(message) {
    scaffoldKey?.currentState?.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  void orderNow(context) {
    final validationMessage = validateInputs();
    validationMessage == "" ? print("object") : showSnackBar(validationMessage);
    final size = product.sizes.firstWhere((size) => size.id == selectedSize);
    final cut = product.cuts.firstWhere((cut) => cut.id == slectedCut);
    final totalPrice = int.parse(size.price) * count;
    Cart cart = Cart(
        size_key: selectedSize,
        quantity: count.toString(),
        key: product.id,
        id: product.id,
        cut_name: cut.name,
        name: product.title,
        image: product.image,
        cut_key: slectedCut,
        item_price: size.price,
        size_name: size.name);

    isRegistered()
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationScreen(
                isCartPage: false,
                detailContext: context,
                cartData: Cart.encondeToJson([cart]),
                completeCost: totalPrice.toString(),
              ),
            ),
          )
        : alert("الرجاء تسجبل الدخول", context);
  }

  alert(message, ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            content: Text(""),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "حسنا",
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  String validateInputs() {
    if (selectedSize == null) {
      return "اختر حجم الذبيحة";
    } else if (slectedCut == null) {
      return "اختر نوع التقطيع ";
    } else {
      return "";
    }
  }
  void addProductToCart() {
    DBHelper.database(sql_cart_query);
    final size = product.sizes.firstWhere((size) => size.id == selectedSize);
    final cut = product.cuts.firstWhere((cut) => cut.id == slectedCut);
    print('detail${product.id + selectedSize + slectedCut}');
    DBHelper.insert(
        'user_cart',
        {
          'key': product.id + selectedSize + slectedCut,
          'id': product.id ,
          'name': product.title,
          'quantity': count.toString(),
          'size_key': selectedSize,
          'pack': selectedPack,
          'price': size.price,
          'size_name': size.name,
          'item_price': size.price,
          'cut_key': cut.id,
          'cut_name': cut.name,
          'image': product.image
        },
        sql_cart_query);
  }

  static closePage(context) {
    Navigator.of(context).pop();
  }
}
