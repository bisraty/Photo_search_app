import 'package:flutter/material.dart';
import 'package:forall/firstpage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

          theme: ThemeData.dark().copyWith(

            primaryColor: Color(0xff0A0E21),
            scaffoldBackgroundColor:Color(0xff0A0E21),
          ),
      home: firstpage(),
    );
  }
}
