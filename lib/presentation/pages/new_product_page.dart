import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';

class NewProductPage extends StatelessWidget {
  final TextEditingController _titleTextField = TextEditingController();

  NewProductPage({Key? key}) : super(key: key);

  void _addProduct(BuildContext context) {
    context.read<ListBloc>().addProduct( _titleTextField.value.text);
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
