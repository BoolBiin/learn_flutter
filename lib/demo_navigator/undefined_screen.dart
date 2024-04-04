import 'package:flutter/material.dart';

class UndefinedScreen extends StatelessWidget {
  final String? chuoi;

  const UndefinedScreen({super.key, this.chuoi});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Undefined Screen"),
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
