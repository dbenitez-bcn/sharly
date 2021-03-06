import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/domain/valueObjects/product.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';
import 'package:sharlyapp/presentation/widgets/empty_list.dart';
import 'package:sharlyapp/presentation/widgets/product_view.dart';

class SharlyListView extends StatelessWidget {
  const SharlyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state is ListSelectSuccess) {
          return StreamBuilder<List<Product>>(
            stream: context.read<ListBloc>().getProducts(),
            builder: _buildBody,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildBody(context, AsyncSnapshot<List<Product>> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data!.isNotEmpty) {
        return _buildList(snapshot.data!);
      }
      return const EmptyList();
    } else if (snapshot.hasError) {
      return const Text("Error de conexion. Por favor, intentalo más tarde");
    } else {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
  }

  Widget _buildList(List<Product> products) {
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
        key: Key(products[index].id),
        direction: DismissDirection.endToStart,
        child: ProductView(products[index]),
        onDismissed: (_) {
          context.read<ListBloc>().removeProduct(products[index].id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text("Se ha eliminado ${products[index].title} de la lista."),
            ),
          );
        },
        background: Container(
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 24.0,
              ),
            ),
          ),
          color: Colors.red[700],
        ),
      ),
      itemCount: products.length,
    );
  }
}
