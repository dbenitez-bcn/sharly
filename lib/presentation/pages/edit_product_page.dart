import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharlyapp/domain/valueObjects/product.dart';
import 'package:sharlyapp/presentation/blocs/list/list_bloc.dart';

class EditProductPage extends StatelessWidget {
  final Product product;
  final TextEditingController _titleTextField = TextEditingController();
  final ValueNotifier<int> _quantityController;

  EditProductPage(this.product, {Key? key})
      : _quantityController = ValueNotifier(product.quantity),
        super(key: key);

  void _updateProduct(BuildContext context) {
    product.title = _titleTextField.text;
    product.quantity = _quantityController.value;
    context.read<ListBloc>().updateProduct(product);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _titleTextField.text = product.title;
    return Scaffold(
      appBar: AppBar(title: const Text("Editar producto")),
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
                  labelText: "Producto",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      if (_quantityController.value > 1) {
                        _quantityController.value--;
                      }
                    },
                    child: const Circle(icono: Icons.remove)),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 3.0),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: _quantityController,
                        builder: (context, value, child) {
                          return Text(
                            "$value",
                            style: const TextStyle(fontSize: 24.0),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () => _quantityController.value++,
                    child: const Circle(icono: Icons.add)),
              ],
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _titleTextField,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: value.text.isNotEmpty
                      ? () => _updateProduct(context)
                      : null,
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

class Circle extends StatelessWidget {
  final IconData icono;

  const Circle({Key? key, required this.icono}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[300],
        shape: BoxShape.circle,
      ),
      child: Icon(
        icono,
        color: Colors.white,
        size: 32.0,
      ),
    );
  }
}
