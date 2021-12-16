import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/domain/valueObjects/product.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';
import 'package:sharlyapp/presentation/pages/edit_product_page.dart';

class ProductView extends StatelessWidget {
  final Product _product;

  const ProductView(this._product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          onTap: () =>
              BlocProvider.of<ListBloc>(context).increaseQuantity(_product),
          onLongPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProductPage(_product)));
          },
          title: Text(_product.title),
          trailing: Text("x${_product.quantity}"),
        ),
      ),
    );
  }
}
