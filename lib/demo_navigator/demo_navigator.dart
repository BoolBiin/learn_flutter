import 'package:flutter/material.dart';
import 'package:learn_flutter/demo_navigator/home_screen.dart';
import 'package:learn_flutter/demo_navigator/undefined_screen.dart';
import 'package:learn_flutter/demo_navigator/profile_screen.dart';
import 'package:learn_flutter/demo_navigator/setting_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/setting': (context) => SettingScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => HomeScreen());
          case '/profile':
            return MaterialPageRoute(builder: (context) => ProfileScreen());
          case '/setting':
            return MaterialPageRoute(builder: (context) => SettingScreen());
          default:
            final String chuoi = settings.arguments as String;
            return MaterialPageRoute(
                builder: (context) => UndefinedScreen(chuoi: chuoi));
        }
      },
    );
  }
}
