import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/auth.dart';
import 'package:multishopping_app/modules/products.dart';
import 'package:multishopping_app/screens/auth_screen.dart';
import 'package:multishopping_app/screens/homePage_screen.dart';
import 'package:multishopping_app/screens/orderPage_Screen.dart';
import 'package:multishopping_app/screens/profilePage_screen.dart';

class TabViewScreen extends ConsumerStatefulWidget {
  static final routeName = '/';

  const TabViewScreen({super.key});

  @override
  ConsumerState<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends ConsumerState<TabViewScreen> {
  var pages = [];

  int page_index = 0;

  @override
  void initState() {
    ref.read(productNotifierProvider.notifier).fetchAndSetProducts();

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
    return FutureBuilder(
      future: ref.read(authNotifierProvider.notifier).isAuth,
      builder: (context, snapshot) {
        return snapshot.data != false
            ? Scaffold(
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
                        backgroundColor:
                            Theme.of(context).bottomAppBarTheme.color,
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        backgroundColor:
                            Theme.of(context).bottomAppBarTheme.color,
                        icon: Icon(Icons.shopping_bag),
                        label: "Orders",
                      ),
                      BottomNavigationBarItem(
                        backgroundColor:
                            Theme.of(context).bottomAppBarTheme.color,
                        icon: Icon(Icons.person),
                        label: "Profile",
                      ),
                    ]),
              )
            : AuthScreen();
      },
    );
  }
}
