import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/theme_module.dart';
import 'package:multishopping_app/screens/auth_screen.dart';
import 'package:multishopping_app/screens/cartPage_screen.dart';
import 'package:multishopping_app/screens/products_screen.dart';
import 'package:multishopping_app/screens/tabView_screen.dart';
import 'package:multishopping_app/theme/theme_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeModule.configureStoreModuleInjection();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeStore _themeStore = getIt<ThemeStore>();
    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MultiShopping App',
          theme: _themeStore.darkMode
              ? ThemeData(
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor:
                      Colors.grey[600], // Dark but not completely black
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                    brightness: Brightness.dark,
                  ),
                  useMaterial3: true,
                  appBarTheme: AppBarTheme(
                    backgroundColor:
                        Colors.deepPurple[700], // A dark purple for contrast
                  ),
                  bottomAppBarTheme: BottomAppBarTheme(
                    color: Colors.deepPurple[800], // A slightly darker purple
                  ),
                )
              : ThemeData(
                  scaffoldBackgroundColor: Colors.amber[50],
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      },
    );
  }
}
