import 'package:doan_tn/pages/cart/cart_page.dart';
import 'package:doan_tn/pages/favorite_page.dart';
import 'package:doan_tn/pages/home_page.dart';
import 'package:doan_tn/pages/profile_page.dart';
import 'package:flutter/material.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _pages = [
    const HomePage(),
    const FavoritePage(),
    const CartPage(),
    ProfilePage(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: const Text(
      //     "SUPERMARKET",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal.shade100,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "Favourite",
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: "Cart",
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: "My account",
              ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
