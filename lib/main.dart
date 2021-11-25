import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/data/datasources/firebase_users_repository.dart';
import 'package:sharlyapp/presentation/blocs/user/user_bloc.dart';
import 'package:sharlyapp/presentation/pages/main_page.dart';
import 'package:sharlyapp/services/auth_service.dart';

void main() {
  runApp(Sharly());
}

class Sharly extends StatelessWidget {
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
      home: _initializeApp(
        child: MainPage(),
      ),
    );
  }

  Widget _initializeApp({required Widget child}) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _message("No pudimos iniciar la Sharly...");
        } else if (snapshot.connectionState == ConnectionState.done) {
          return _initializeBloc(child);
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }

  Widget _initializeBloc(Widget child) {
    return BlocProvider(
      create: (_) =>
          UserBloc(AuthService(FirebaseUsersRepository(FirebaseAuth.instance))),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserAuthSuccess) {
            return child;
          } else if (state is UserAuthInProgress) {
            return const CircularProgressIndicator.adaptive();
          } else if (state is UserInitial) {
            context.read<UserBloc>().add(UserSignedIn());
            return const SizedBox(width: 10, height: 10);
          } else {
            return _message("Es tu problemo");
          }
        },
      ),
    );
  }
}
