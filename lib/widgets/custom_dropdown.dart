import 'package:flutter/material.dart';
import 'package:flutter_covid_app/models/covidProvince.dart';

class ProvinceDropdown extends StatelessWidget {
  late final List<CovidProvince> provinces;
  final String province;
  final Function(String?) onChanged;

  ProvinceDropdown(
      {required this.provinces,
      required this.onChanged,
      required this.province});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        height: 30,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(30),
          
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
              
          value: province,
          items: provinces
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e.province.toString()),
                  value: e.province.toString(),
                  //value: provinces.indexOf(e).toString(),
                ),
              )
              .toList(),
          onChanged: onChanged,
        )));
  }
}
