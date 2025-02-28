import 'package:flutter/material.dart';
import 'package:multishopping_app/screens/homePage_screen.dart';
import 'package:multishopping_app/screens/orderPage_Screen.dart';
import 'package:multishopping_app/screens/profilePage_screen.dart';

class TabViewScreen extends StatefulWidget {
  static final routeName = '/';

  const TabViewScreen({super.key});

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> {
  var pages = [];

  int page_index = 0;

  @override
  void initState() {
    pages = [
      HomePageScreen(),
      OrderPageScreen(),
      ProfilePageScreen(),
    ];
    super.initState();
  }

  void selectPage(int index) {
    setState(() {
      page_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page_index],
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 16,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedIconTheme: IconThemeData(size: 25),
          selectedItemColor: Colors.amberAccent[400],
          unselectedItemColor: Colors.white,
          currentIndex: page_index,
          onTap: selectPage,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).bottomAppBarTheme.color,
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).bottomAppBarTheme.color,
              icon: Icon(Icons.shopping_bag),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).bottomAppBarTheme.color,
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ]),
    );
  }
}
