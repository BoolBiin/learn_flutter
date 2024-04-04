import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLogin = true;
  String signUpEmail = '';
  String signUpPassword = '';

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;

      emailController.text = '';
      passwordController.text = '';
      confirmPasswordController.text = '';
    });
  }

  // Tạo một TextEditingController cho mỗi field.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  void dispose() {
    // Đừng quên dispose các controller khi không cần nữa để tránh memory leak
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (email == '' || password == '') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Email hoặc Password không để trống'),
          );
        },
      );
    }
    if (!isLogin) {
      //'SIGN UP'
      if (password != confirmPassword) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Confirm password không chính xác'),
            );
          },
        );
      } else {
        signUpEmail = email;
        signUpPassword = password;

        toggleForm();
      }
    } else {
      //'LOGIN'
      if (email == signUpEmail && password == signUpPassword) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    email: email,
                  )),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Email và password không chính xác'),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SingleChildScrollView(
        // Thêm SingleChildScrollView
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height /
                    4), // Tạo khoảng cách từ top screen
            MyShopLogo(),
            SizedBox(height: 50),
            Center(
              child: Card(
                elevation: 8.0, // Đổ bóng cho Card
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Đặt Column chiếm không gian tối thiểu
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(labelText: 'E-Mail'),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true, // Che dấu mật khẩu
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        if (!isLogin)
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration:
                                InputDecoration(labelText: 'Confirm Password'),
                          ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text(
                            isLogin ? 'LOGIN' : 'SIGN UP',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _submitForm,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                isLogin ? Colors.purple : Colors.orange),
                          ),
                        ),
                        TextButton(
                          child: Text(
                              isLogin ? 'SIGNUP INSTEAD' : 'LOGIN INSTEAD'),
                          onPressed: toggleForm,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyShopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.2, // Góc xoay được tính bằng radian
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [Colors.red, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 4,
              blurRadius: 20,
            ),
          ],
        ),
        child: Text(
          'MyShop',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String email;
  const HomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chào mừng ${email}"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Logout'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
