import 'package:flutter/material.dart';
import 'package:sharlyapp/presentation/widgets/sharly_list_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sharly"),
      ),
      body: const SharlyListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/newProduct'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
