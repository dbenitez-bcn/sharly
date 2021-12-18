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
        debugShowCheckedModeBanner: false,
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
              print(snapshot.error!);
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
    User user = await _initSession(ifNew: listBloc.addList);
    List<SharedList> list = await listBloc.getListsByUserId(user.uid);
    listBloc.add(ListChangedEvent(list.first));
  }

  Future<User> _initSession({required Function(String uid, String title) ifNew}) async {
    if (FirebaseAuth.instance.currentUser == null) {
      UserCredential userCredentials =
          await FirebaseAuth.instance.signInAnonymously();
      if (userCredentials.additionalUserInfo != null &&
          userCredentials.additionalUserInfo!.isNewUser) {
        await ifNew(userCredentials.user!.uid, "Lista de la compra");
      }
    }
    return FirebaseAuth.instance.currentUser!;
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
