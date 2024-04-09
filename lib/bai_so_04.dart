import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  final TextEditingController emailController =
      TextEditingController(text: 'hung');
  final TextEditingController passwordController =
      TextEditingController(text: '1');
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
          return const AlertDialog(
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
            return const AlertDialog(
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
      if ((email == signUpEmail && password == signUpPassword) ||
          (email == 'hung' && password == "1")) {
        Navigator.pushReplacement(
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
            return const AlertDialog(
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
            const SizedBox(height: 50),
            Center(
              child: Card(
                elevation: 8.0, // Đổ bóng cho Card
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Đặt Column chiếm không gian tối thiểu
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          decoration:
                              const InputDecoration(labelText: 'E-Mail'),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true, // Che dấu mật khẩu
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                        ),
                        if (!isLogin)
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password'),
                          ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                isLogin ? Colors.purple : Colors.orange),
                          ),
                          child: Text(
                            isLogin ? 'LOGIN' : 'SIGN UP',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: toggleForm,
                          child: Text(
                              isLogin ? 'SIGNUP INSTEAD' : 'LOGIN INSTEAD'),
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
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
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
        child: const Text(
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

class HomePage extends StatefulWidget {
  final String email;
  HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> products = [
    // Product('Demo', '2000', '231245124',
    //     'https://vsmall.vn/wp-content/uploads/2022/06/hinh-anh-con-gai-cute-de-thuong-cute-anime-hoat-hinh-xinh.jpg'),
    // Product(
    //     'Product 2', '2000', '231245124', 'https://example.com/product2.jpg'),
    // Product('Ao thun', '2000', '231245124', 'https://example.com/aothun.jpg'),
    // // Add more products here
  ];

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void addOrUpdateProductList(Product updatedProduct) {
    setState(() {
      // Here, you would find and update the product in your list
      // For demonstration, I'm just adding the product to the list\
      int index = products
          .indexWhere((element) => element.title == updatedProduct.title);
      if (index != -1) {
        // Item exists, update it
        products[index].price = updatedProduct.price;
        products[index].description = updatedProduct.description;
        products[index].imageUrl = updatedProduct.imageUrl;
      } else {
        // Item doesn't exist, add it
        products.add(updatedProduct);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chào mừng ${widget.email}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductPage(
                          product: Product(
                              title: "",
                              price: "",
                              description: "",
                              imageUrl: ""),
                          onUpdate: addOrUpdateProductList,
                        )),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return ProductItem(
            product: product,
            onEdit: () {
              // Thêm hành động chỉnh sửa ở đây
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductPage(
                          product: product,
                          onUpdate: addOrUpdateProductList,
                        )),
              );
            },
            onDelete: () => _deleteProduct(index),
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ProductItem(
      {required this.product, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
        // In case the image fails to load, you can display an initial letter or icon
        onBackgroundImageError: (exception, stackTrace) {
          // Handle the error, for example, by setting a placeholder image
        },
        // child: Text(product
        //     .title[0]), // Displays the first letter of the title as a fallback
      ),
      title: Text(product.title),
      trailing: Wrap(
        spacing: 12, // space between two icons
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
            // onPressed: () {
            //   // Your edit action here
            // },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
            // onPressed: () {
            //   // Your delete action here
            // },
          ),
        ],
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  final Product product;
  final Function onUpdate;

  const ProductPage({super.key, required this.product, required this.onUpdate});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController =
      TextEditingController(text: widget.product.title);
  late TextEditingController priceController =
      TextEditingController(text: widget.product.price);
  late TextEditingController descriptionController =
      TextEditingController(text: widget.product.description);
  late TextEditingController imageUrlController =
      TextEditingController(text: widget.product.imageUrl);
  @override
  void dispose() {
    // Đừng quên dispose các controller khi không cần nữa để tránh memory leak
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void _capNhat() {
    if (_formKey.currentState!.validate()) {
      // Create an updated product object
      Product updatedProduct = Product(
          title: titleController.text,
          price: priceController.text,
          description: descriptionController.text,
          imageUrl: imageUrlController.text
          // ... other properties
          );

      // Call the onUpdate callback with the updated product
      widget.onUpdate(updatedProduct);

      // Pop the current page to return to the previous screen
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Navigator.pop(context);
              _capNhat();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  }),
              TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number),
              TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description.';
                    }
                    return null;
                  }),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                        controller: imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                        ),
                        onChanged: (value) {
                          setState(
                              () {}); // Trigger a rebuild of the FutureBuilder
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an image URL.';
                          }
                          return null;
                        }),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: FutureBuilder(
                      future: _getImage(imageUrlController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return CircularProgressIndicator();
                        if (snapshot.hasError)
                          return Text('Error loading image');

                        return Image.network(imageUrlController.text);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage(String url) async {
    // Replace this with your logic to get the image URL
    await precacheImage(NetworkImage(url), context);
  }
}

class Product {
  late String title;
  late String price;
  late String description;
  late String imageUrl;
  Product(
      {required this.title,
      required this.price,
      required this.description,
      required this.imageUrl});
}
