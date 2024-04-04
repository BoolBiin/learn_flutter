import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final chuoi = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("Setting Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go back ${chuoi}'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
