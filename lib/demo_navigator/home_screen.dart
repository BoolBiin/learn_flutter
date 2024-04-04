import 'package:flutter/material.dart';
import 'package:learn_flutter/demo_navigator/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Go to Profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            chuoi: 'đây là tui',
                          )),
                );
              },
            ),
            ElevatedButton(
              child: Text('Go to Setting'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/setting',
                  arguments: '123',
                );
              },
            ),
            ElevatedButton(
              child: Text('Go to Undefined'),
              onPressed: () {
                Navigator.pushNamed(context, '/assd', arguments: 'tôi là tôi');
              },
            )
          ],
        ),
      ),
    );
  }
}
