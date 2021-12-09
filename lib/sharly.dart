import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/domain/valueObjects/shared_list.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';
import 'package:sharlyapp/presentation/pages/main_page.dart';
import 'package:sharlyapp/presentation/pages/new_product_page.dart';

class Sharly extends StatelessWidget {
  const Sharly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListBloc listBloc = ListBloc();
    return BlocProvider(
      create: (_) => listBloc,
      child: MaterialApp(
        title: 'Sharly',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        routes: <String, WidgetBuilder>{
          '/newProduct': (BuildContext context) => NewProductPage(),
        },
        home: FutureBuilder<void>(
          future: _initializeApp(listBloc),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _loaderIndicator();
            } else if (snapshot.hasError ||
                FirebaseAuth.instance.currentUser == null) {
              return _message("No pudimos iniciar la Sharly.");
            } else {
              return const MainPage();
            }
          },
        ),
      ),
    );
  }

  Future<void> _initializeApp(ListBloc listBloc) async {
    User user = await _initSession(ifNew: _createDefaultList);
    SharedList list = await _getListByUserId(user.uid);
    listBloc.add(ListChangedEvent(list));
  }

  Future<SharedList> _getListByUserId(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection("shared_lists")
        .doc(uid)
        .get();
    return SharedList(snapshot.data()!["lists"].first as String);
  }

  Future<User> _initSession({required Function(String uid) ifNew}) async {
    if (FirebaseAuth.instance.currentUser == null) {
      UserCredential userCredentials =
          await FirebaseAuth.instance.signInAnonymously();
      if (userCredentials.additionalUserInfo != null && userCredentials.additionalUserInfo!.isNewUser) {
        await ifNew(userCredentials.user!.uid);
      }
    }
    return FirebaseAuth.instance.currentUser!;
  }

  Future<void> _createDefaultList(String uid) async {
    // TODO: Move this to bloc
    DocumentReference defaultList = await FirebaseFirestore.instance
        .collection("lists")
        .add({"title": "Lista de la compra"});
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
}
