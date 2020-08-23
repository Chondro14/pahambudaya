import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemSearching extends StatelessWidget {
  final List<IconData> icon = [Icons.home, Icons.fastfood];
  List<String> title = ['Title', 'Makanan'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: icon.length,
      itemBuilder: (context, index) {
        return InkWell(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Chip(
            avatar: Icon(icon[index]),
            label: Text(
              title[index],
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.yellow[800],
          ),
        ));
      },
    );
  }
}
