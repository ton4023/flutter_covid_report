import 'package:flutter/material.dart';
import 'package:flutter_covid_app/screens/screen.dart';

// import 'package:flutter_covid_app/screens/home_screen.dart';
// import 'package:flutter_covid_app/screens/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(body: TestScreen(),)
      //home: Scaffold(body: HomeScreen(),)
    );
  }
}
