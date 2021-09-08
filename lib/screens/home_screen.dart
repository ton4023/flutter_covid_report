import 'package:flutter/material.dart';
import 'package:flutter_covid_app/widgets/widget.dart';

class HomeScreen extends StatelessWidget with PreferredSizeWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        body: Container(
          
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
