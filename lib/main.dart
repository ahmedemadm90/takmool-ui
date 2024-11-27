import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for locking orientation
import 'package:sizer/sizer.dart';
import 'package:takamool/auth/attendance_screen.dart';
import 'package:takamool/auth/home_screen.dart';
import 'package:takamool/auth/login_screen.dart';
import 'package:takamool/auth/reset_passwors_screen.dart';
import 'package:takamool/auth/setting_screen.dart';
import 'package:takamool/requests/my_requests_screen.dart';
import 'package:takamool/requests/requests_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
      home: ResponsiveSizer(
        builder: (context, orientation, screenType) => Scaffold(
          body: SafeArea(child: MyRequestsScreen()),
        ),
      ),
    );
  }
}
