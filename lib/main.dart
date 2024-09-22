import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:takamool/auth/home_screen.dart';
import 'package:takamool/auth/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Takamool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveSizer(builder: (context,orientation,screenType)=>Scaffold(
        body: SafeArea(child: HomeScreen()),
      )),
    );
  }
}
