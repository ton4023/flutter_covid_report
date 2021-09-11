

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProvinceDropdown extends StatelessWidget {
  final List<String> provinces = [
    'aa','bb','ccc','dddd', ];
   String province;
  final Function(String?) onChanged;

  ProvinceDropdown({
    required this.onChanged,
    required this.province
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(30)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: province,
          items: provinces.map((e) => DropdownMenuItem(
            child: Text(e.toString()),
            value: e,)).toList(),
          onChanged: onChanged,    
        )
      )
    );
  }
}
