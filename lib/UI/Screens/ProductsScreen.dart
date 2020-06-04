import 'package:flutter/material.dart';
import 'package:zapihatalyoumapp/Bloc/ProductsBloc.dart';
import 'package:zapihatalyoumapp/Bloc/bloc_provider.dart';
import 'package:zapihatalyoumapp/DataLayer/Product.dart';
import 'package:zapihatalyoumapp/UI/widgets/ProductItem.dart';
import 'package:zapihatalyoumapp/shared_data.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 150,
        child: buildProductGride(context),
      ),
    );
  }

  Widget buildProductGride(context) {
    final bloc = ProductsQueryBloc();
    bloc.getProducts();
    return BlocProvider<ProductsQueryBloc>(
      bloc: bloc,
      child: StreamBuilder<List<Product>>(
          stream: bloc.productStream,
          builder: (context, snapshot) {
            return productList == null
                ? Container()
                : GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: productList.length,
                    itemBuilder: (ctx, i) {
                      return ProductItem(
                        product: productList[i],
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.3),
                      mainAxisSpacing: 10,
                    ),
                  );
          }),
    );
  }
}
