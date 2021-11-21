import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sharly"),
      ),
      body: FutureBuilder<UserCredential>(
        future: FirebaseAuth.instance.signInAnonymously(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
          return const Center(
            child: Text("No pudimos iniciar la Sharly..."),
          );
        }

        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return Center(
            child: Text(snapshot.data!.user!.uid),
          );
        }


        return CircularProgressIndicator.adaptive();
        },
      ),
    );
  }
}
