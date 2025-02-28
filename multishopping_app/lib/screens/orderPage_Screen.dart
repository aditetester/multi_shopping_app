import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multishopping_app/modules/order.dart';
import 'package:multishopping_app/widgets/order_detail_item.dart';

class OrderPageScreen extends ConsumerWidget {
  const OrderPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.read(orderNotifierProvider.notifier);
    return ListView.builder(
      itemCount: orderData.orders.length,
      itemBuilder: (ctx, i) => OrderDetailItem(orderData.orders[i]),
    );
  }
}
