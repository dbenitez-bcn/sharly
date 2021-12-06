import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/domain/valueObjects/shared_list.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';
import 'package:sharlyapp/presentation/pages/main_page.dart';
import 'package:sharlyapp/presentation/pages/new_product_page.dart';

void main() {
  runApp(const Sharly());
}

class Sharly extends StatelessWidget {
  const Sharly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListBloc(),
      child: MaterialApp(
        title: 'Sharly',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        routes: <String, WidgetBuilder>{
          '/newProduct': (BuildContext context) => NewProductPage(),
        },
        home: FutureBuilder<void>(
          future: _initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _loaderIndicator();
            } else if (snapshot.hasError ||
                FirebaseAuth.instance.currentUser == null) {
              return _message("No pudimos iniciar la Sharly.");
            } else {
              return _initializeBloc(
                child: const MainPage(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _initializeApp() async {
    await Firebase.initializeApp();
    await _initSession(ifNew: _createDefaultList);
  }

  Future<void> _initSession({required Function(String uid) ifNew}) async {
    if (FirebaseAuth.instance.currentUser == null) {
      UserCredential userCredentials =
          await FirebaseAuth.instance.signInAnonymously();
      if (userCredentials.additionalUserInfo!.isNewUser) {
        await ifNew(userCredentials.user!.uid);
      }
    }
  }

  Future<void> _createDefaultList(String uid) async {
    DocumentReference defaultList = await FirebaseFirestore.instance
        .collection("lists")
        .add({"title": "Lista de la compra", "products": []});
    await FirebaseFirestore.instance.collection("shared_lists").doc(uid).set({
      "lists": [defaultList.id]
    });
  }

  Widget _message(String message) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }

  Widget _loaderIndicator() {
    // TODO: Add splash screen to load
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _initializeBloc({required Widget child}) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection("shared_lists")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loaderIndicator();
        } else if (snapshot.hasError) {
          return _message("No pudimos iniciar la Sharly...");
        } else {
          SharedList list =
              SharedList(snapshot.data!.data()!["lists"].first as String);
          context.read<ListBloc>().add(ListChangedEvent(list));
          return child;
        }
      },
    );
  }
}
