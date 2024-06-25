import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../product/product_page.dart';
import '../profile/profile_page.dart';

class CartPage extends StatefulWidget {
  final Map<String, dynamic>? product;

  CartPage({this.product});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    if (widget.product != null && widget.product!.isNotEmpty) {
      addToCart(widget.product!);
    }
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProductPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(product: null),
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
            child: Text(
          'Cart',
          style: TextStyle(fontSize: 28),
        )),
        automaticallyImplyLeading: false,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var item = cartItems[index];
                return ListTile(
                  leading: item['image'] != null
                      ? Image.network(
                          item['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                  title: Text(item['title'] ?? 'No Title'),
                  subtitle: Text('\$${item['price']?.toString() ?? '0.00'}'),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2, // Index of the current page (CartPage)
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
