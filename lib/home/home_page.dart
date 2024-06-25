import 'package:flutter/material.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:e_commerce_app/product/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Product> products = [];
  final int displayCount = 25;

  final List<String> imgList = [
    'assets/01.jpg',
    'assets/02.jpg',
    'assets/03.jpg',
    'assets/04.jpg',
    'assets/05.jpg',
  ];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    List<Product> allProducts = await ApiService().fetchProducts();
    setState(() {
      products = getRandomProducts(allProducts, displayCount);
    });
  }

  List<Product> getRandomProducts(List<Product> allProducts, int count) {
    final random = Random();
    return List<Product>.generate(
      count,
      (_) => allProducts[random.nextInt(allProducts.length)],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        // Navigate to Home or handle Home page logic
        break;
      case 1:
        // Navigate to Products page
        Navigator.pushNamed(context, '/product');
        break;
      case 2:
        // Navigate to Cart page
        Navigator.pushNamed(context, '/cart');
        break;
      case 3:
        // Navigate to Profile page
        Navigator.pushNamed(context, '/profile');
        break;
      default:
    }
  }

  Widget _buildHomePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: imgList
              .map((item) => Container(
                    child: Center(
                      child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: _buildProductPage(),
        ),
      ],
    );
  }

  Widget _buildProductPage() {
    return products.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            padding: EdgeInsets.all(10.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        products[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        products[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '\$${products[index].price}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Shop Karo',
          style: TextStyle(fontSize: 28),
        )),
      ),
      body: _buildHomePage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
