import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/presentation/blocs/user/user_bloc.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uuid = (context.read<UserBloc>().state as UserAuthSuccess).user.uuid;
    Widget good = StreamBuilder<List<dynamic>>(
      stream: FirebaseFirestore
          .instance
          .collection("users_lists")
          .doc(uuid)
          .snapshots().map((DocumentSnapshot<Map<String, dynamic>> snapshot) =>  snapshot.data()!["lists"]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasError) {
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.map((e) => Text(e)).toList(),
        );
      },
    );
    Widget foo = StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore
          .instance
          .collection("users_lists")
          .doc("uuid")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text("Problemas");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        print(snapshot.data!.exists);
        return Text("Hello");
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sharly"),
      ),
      body: foo,
    );
  }
}
