import 'package:flutter/material.dart';

class SharlyDrawer extends StatelessWidget {
  const SharlyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            child:  const ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Añadir lista"),
            ),
            onTap: () => Navigator.pushNamed(context, '/newList'),
          ),
        ],
      ),
    );
  }
}
