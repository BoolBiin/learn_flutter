import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String? chuoi;

  const ProfileScreen({super.key, this.chuoi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
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
