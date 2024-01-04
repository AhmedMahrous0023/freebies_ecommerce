import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/views/home_screen.dart';
import 'package:freebies_ecommerce/views/wish_list_screen.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({super.key});

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorScreenState();
}

class _BottomNavigatorScreenState extends State<BottomNavigatorScreen> {
  List<Widget> _pages = [
    HomeScreen(),
    WishListScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[100],
          currentIndex: _currentindex,
          selectedFontSize: 19,
          selectedItemColor: Colors.blue,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(fontSize: 15),
          iconSize: 25,
          onTap: (index) {
            setState(() {
              _currentindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded), label: "Wishlist"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: "Order"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: "Login"),
          ]),
      body: _pages[_currentindex],
    );
  }
}
