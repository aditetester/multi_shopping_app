import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/screens/auth_screen.dart';
import 'package:multishopping_app/screens/cartPage_screen.dart';
import 'package:multishopping_app/screens/products_screen.dart';
import 'package:multishopping_app/screens/tabView_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MultiShopping App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.amber[50],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple[100],
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.deepPurple[300],
        ),
      ),
      initialRoute: TabViewScreen.routeName,
      routes: {
        TabViewScreen.routeName: (ctx) => TabViewScreen(),
        CartPageScreen.routeName: (ctx) => CartPageScreen(),
        ProductsScreen.routeName: (ctx) => ProductsScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
      },
    );
  }
}
