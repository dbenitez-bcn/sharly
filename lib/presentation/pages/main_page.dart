import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/domain/aggregates/sharly_list.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sharly"),
      ),
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if (state is ListSelectSuccess) {
            return StreamBuilder<SharlyList>(
              stream: FirebaseFirestore.instance
                  .collection("lists")
                  .doc(state.currentList.id)
                  .snapshots()
                  .map((event) => SharlyList.fromMap(event.data()!)),
              builder: (context, AsyncSnapshot<SharlyList> snapshot) {
                if (snapshot.hasData) {
                  // TODO Add products list
                  return Text(snapshot.data!.title);
                }
                return Text("Error de conexion.");
              },
            );
          }
          else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/newProduct'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
