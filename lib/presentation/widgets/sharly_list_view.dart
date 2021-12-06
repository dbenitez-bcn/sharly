import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/domain/valueObjects/product.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';
import 'package:sharlyapp/presentation/widgets/empty_list.dart';

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
      return const Text(
          "Error de conexion. Por favor, intentalo más tarde");
    } else {
      return Container();
    }
  }
  
  Widget _buildList(List<Product> products) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          ListTile(title: Text(products[index].title)),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Divider(),
      ),
      itemCount: products.length,
    );
  }
}
