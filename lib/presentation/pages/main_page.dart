import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sharly"),
      ),
      body: const Center(
        child: Text("Hello sharly!"),
      ),
    );
  }
}
