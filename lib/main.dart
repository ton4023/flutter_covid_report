import 'package:flutter/material.dart';
import 'package:flutter_covid_app/screens/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splash());
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home: Scaffold(body: HomeScreen()),
            );
          }
        });
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 3));
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: lightMode
          ? const Color(0x00e1f5fe).withOpacity(1.0)
          : const Color(0x00042a49).withOpacity(1.0),
      body: Center(
          child: lightMode
              ? Container(
                height: 200,
                child: Image.asset('images/42530.png'))
              : Container(
                height: 200,
                child: Image.asset('images/42530.png'))),
    );
  }
}
