import 'package:flutter/material.dart';

class BadgeView extends StatelessWidget {
  final Widget child;
  final String value;

  const BadgeView({
    required this.child,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 2,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: value == '0' ? Colors.transparent : Colors.orangeAccent,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value == '0' ? "" : value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
