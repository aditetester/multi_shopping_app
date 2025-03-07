import 'package:flutter/material.dart';
import 'package:multishopping_app/presentation/cart/cartPage_screen.dart';
import 'package:multishopping_app/presentation/products/products_screen.dart';
import 'package:multishopping_app/presentation/tabView_screen.dart';
import '../../presentation/login/auth_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  TabViewScreen.routeName: (ctx) => TabViewScreen(),
  CartPageScreen.routeName: (ctx) => CartPageScreen(),
  ProductsScreen.routeName: (ctx) => ProductsScreen(),
  AuthScreen.routeName: (ctx) => AuthScreen(),
};
