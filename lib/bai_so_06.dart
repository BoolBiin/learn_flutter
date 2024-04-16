import 'package:flutter/foundation.dart';
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
  final List<Product> products = [
    Product(
        title: 'Gái 1',
        price: '5000',
        description: '231245124',
        imageUrl:
            'https://vsmall.vn/wp-content/uploads/2022/06/hinh-anh-con-gai-cute-de-thuong-cute-anime-hoat-hinh-xinh.jpg'),
    Product(
        title: 'Gái 2',
        price: '2000',
        description: '231245124',
        imageUrl:
            'https://vsmall.vn/wp-content/uploads/2022/06/hinh-anh-con-gai-cute-de-thuong-cute-anime-hoat-hinh-xinh.jpg'),
    Product(
        title: 'Gái 3',
        price: '1500',
        description: '231245124',
        imageUrl:
            'https://vsmall.vn/wp-content/uploads/2022/06/hinh-anh-con-gai-cute-de-thuong-cute-anime-hoat-hinh-xinh.jpg'),
    // Add more products here
  ];
  final List<ProductCart> carts = [];

  void onAddToCard(ProductCart productCart) {
    setState(() {
      // Here, you would find and update the product in your list
      // For demonstration, I'm just adding the product to the list\
      int index =
          carts.indexWhere((element) => element.title == productCart.title);
      if (index != -1) {
        // Item exists, update it
        carts[index].qty += productCart.qty;
      } else {
        // Item doesn't exist, add it
        carts.add(productCart);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int soLuong = 0;
    carts.forEach((item) {
      //getting the key direectly from the name of the key
      soLuong += item.qty;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Chào mừng"),
        actions: [
          ShoppingCartBadge(
            itemCount: soLuong,
            lstProductCart: carts,
          ),
        ],
      ),

      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text('Drawer Header'),
      //       ),
      //       ListTile(
      //         title: const Text('Item 1'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Item 2'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: GridView.count(
        crossAxisCount: 2, // decides number of columns
        shrinkWrap: true, // clear space issue
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(products.length, (index) {
          var product = products[index];
          return ProductItemCard(product: product, addToCard: onAddToCard);
        }),
      ),
    );
  }
}

class ShoppingCartBadge extends StatelessWidget {
  final int itemCount;
  final List<ProductCart> lstProductCart;

  ShoppingCartBadge({required this.itemCount, required this.lstProductCart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailCart(
                        lstProcductCart: lstProductCart,
                      )),
            );
          },
          iconSize: 35.0,
        ),
        if (itemCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                '$itemCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class ProductItemCard extends StatefulWidget {
  final Product product;
  final Function addToCard;

  ProductItemCard({required this.product, required this.addToCard});

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  void _themGioHang() {
    // Create an updated product object
    ProductCart addProduct = ProductCart(
        title: widget.product.title,
        price: widget.product.price,
        imageUrl: widget.product.imageUrl,
        qty: 1
        // ... other properties
        );

    // Call the onUpdate callback with the updated product
    widget.addToCard(addProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Image.network(
              widget.product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailProduct(
                              product: widget.product,
                            )),
                  );
                },
              ),
              Text(widget.product.title),
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: _themGioHang,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailProduct extends StatelessWidget {
  final Product product;
  const DetailProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(product.title),
        // ),
        body: Center(
          child: Stack(
            children: [
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.network(
                    product.imageUrl, // Replace with your image url
                    width: MediaQuery.of(context).size.width,
                  ),
                  // ListTile(
                  //   title: Text(product.title),
                  //   subtitle: Text(product.description),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$' + product.price,
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Text(
                      product.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 20,
                top: 20,
                child: ElevatedButton(
                  child: Text('<='),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                left: 20,
                bottom: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  // Semi-transparent black overlay
                  child: Text(
                    product.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailCart extends StatelessWidget {
  final List<ProductCart> lstProcductCart;
  const DetailCart({super.key, required this.lstProcductCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Title',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Quantity',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Amount',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
              rows: lstProcductCart
                  .map((product) => DataRow(cells: [
                        DataCell(
                          Container(
                            // Set background color here
                            child: Text(
                              product.title,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            child: Text(
                              product.price,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            // Set background color here
                            child: Text(
                              product.qty.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            // Set background color here
                            child: Text(
                              '${(int.parse(product.price) * product.qty)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
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

class ProductCart {
  late String title;
  late String price;
  late String imageUrl;
  late int qty;
  ProductCart(
      {required this.title,
      required this.price,
      required this.imageUrl,
      required this.qty});
}
