import 'package:flutter/material.dart';
import 'package:multishopping_app/modules/cart.dart';

class OrderButton extends StatefulWidget {
  final Cart cart;
  const OrderButton({
    super.key,
    required this.cart,
  });


  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount as double <= 0 || _isLoading)
          ? null
          : () async {
              // setState(() {
              //   _isLoading = true;
              // });
              // await Provider.of<Orders>(context, listen: false).addOrder(
              //   widget.cart.items.values.toList(),
              //   widget.cart.totalAmount,
              // );
              // setState(() {
              //   _isLoading = false;
              // });
              // widget.cart.clear();
            },
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
    );
  }
}
