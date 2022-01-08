import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';

class NewListPage extends StatelessWidget {
  final TextEditingController _titleTextField = TextEditingController();

  NewListPage({Key? key}) : super(key: key);

  void _addProduct(BuildContext context) {
    context.read<ListBloc>().addList(
        FirebaseAuth.instance.currentUser!.uid, _titleTextField.value.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear lista")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: TextField(
                controller: _titleTextField,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nombre de la lista",
                  labelText: "Nombre",
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _titleTextField,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed:
                      value.text.isNotEmpty ? () => _addProduct(context) : null,
                  child: const Text("Crear"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
