import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Sharly());
}

class Sharly extends StatelessWidget {
  Future<void> _initializeApp() async {
    await Firebase.initializeApp();
    await _initSession(ifNew: _createDefaultList);
  }

  Future<void> _initSession({required Function(String uid) ifNew}) async {
    if (FirebaseAuth.instance.currentUser == null) {
      UserCredential userCredentials = await FirebaseAuth.instance.signInAnonymously();
      if (userCredentials.additionalUserInfo!.isNewUser) await ifNew(userCredentials.user!.uid);
    }
  }
  
  Future<void> _createDefaultList(String uid) async {
    DocumentReference defaultList = await FirebaseFirestore.instance.collection("lists").add({
      "title": "Lista de la compra",
      "products": []
    });
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FutureBuilder<void>(
          future: _initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // TODO: Add splash screen to load
              return const Scaffold(
                body: Center(child: CircularProgressIndicator.adaptive()),
              );
            } else if (snapshot.hasError ||
                FirebaseAuth.instance.currentUser == null) {
              return _message("No pudimos iniciar la Sharly...");
            } else {
              return _message(FirebaseAuth.instance.currentUser!.uid);
            }
          }),
    );
  }

// Widget _initializeApp({required Widget child}) {
//   return FutureBuilder(
//     future: Firebase.initializeApp(),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return _message("No pudimos iniciar la Sharly...");
//       } else if (snapshot.connectionState == ConnectionState.done) {
//         return _initializeBloc(child);
//       }
//
//       return const Center(
//         child: CircularProgressIndicator.adaptive(),
//       );
//     },
//   );
// }
//
// Widget _initializeBloc(Widget child) {
//   return BlocProvider(
//     create: (_) =>
//         UserBloc(AuthService(FirebaseUsersRepository(FirebaseAuth.instance))),
//     child: BlocBuilder<UserBloc, UserState>(
//       builder: (context, state) {
//         if (state is UserAuthSuccess) {
//           return child;
//         } else if (state is UserAuthInProgress) {
//           return const CircularProgressIndicator.adaptive();
//         } else if (state is UserInitial) {
//           context.read<UserBloc>().add(UserSignedIn());
//           return const SizedBox(width: 10, height: 10);
//         } else {
//           return _message("Es tu problemo");
//         }
//       },
//     ),
//   );
// }
}
