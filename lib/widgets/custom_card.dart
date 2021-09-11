import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final name;
  final quantity;

  const CustomCard({
    Key? key,
    required this.name,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(name.toString()),
            ),
            ListTile(
              title: Text(quantity.toString()),
            )
          ],
        ),
      ),
    );
  }
}
