import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';

class NewProductPage extends StatelessWidget {
  final TextEditingController _titleTextField = TextEditingController();

  void _addProduct(BuildContext context) {
    final id = (BlocProvider.of<ListBloc>(context).state as ListSelectSuccess)
        .currentList
        .id;
    FirebaseFirestore.instance.collection("lists").doc(id).update({
      "products": FieldValue.arrayUnion([
        {
          "title": _titleTextField.value.text,
          "created_at": DateTime.now(),
        }
      ])
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Añadir producto")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: TextField(
                controller: _titleTextField,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Producto",
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _titleTextField,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed:
                      value.text.isNotEmpty ? () => _addProduct(context) : null,
                  child: const Text("Añadir"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
