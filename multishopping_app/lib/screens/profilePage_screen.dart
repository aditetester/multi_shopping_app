import 'package:flutter/material.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarView = AppBar(
      title: Text("Your Profile"),
    );
    return Scaffold(
      appBar: appBarView,
      body: Center(
        child: Text("Your Profile"),
      ),
    );
  }
}
