import 'package:flutter/material.dart';
import 'package:multishopping_app/screens/tabView_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MultiShopping App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple[200],
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.deepPurple[300],
        ),
      ),
      initialRoute: TabViewScreen.routeName,
      routes: {
        TabViewScreen.routeName: (ctx) => TabViewScreen(),
      },
    );
  }
}
