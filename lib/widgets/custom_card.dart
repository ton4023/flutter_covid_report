import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final name;
  final quantity;
  final color;
  const CustomCard({
    Key? key,
    required this.name,
    required this.quantity, 
    required this.color,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(name.toString(),style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700
              ),),
            ),
            ListTile(
              title: Text(quantity.toString(),style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800
              ),),
            )
          ],
        ),
      ),
    );
  }
}
