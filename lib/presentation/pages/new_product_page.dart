import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewProductPage extends StatelessWidget {
  final TextEditingController _titleTextField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Añadir producto")),
      body: Column(
        children: [
          TextField(
            controller: _titleTextField,
          ),
          ElevatedButton(
            onPressed: () {
              // TODO list id from bloc
              //final id = (BlocProvider.of<ListBloc>(context).state as ListSelectSuccess).currentList.id;
              FirebaseFirestore.instance.collection("lists").doc("cn5WmAk5QM8DCdwfTNOW").update({
                "products": FieldValue.arrayUnion([{
                  "title": _titleTextField.value.text
                }])
              });
              print(_titleTextField.value.text);
            },
            child: const Text("Añadir"),
          )
        ],
      ),
    );
  }
}
