import 'package:flutter/material.dart';
import 'package:virtual_store/models/sales_order.dart';
import 'package:virtual_store/screens/sales/components/sale_order_product_tile.dart';
import 'package:virtual_store/utils/extensions/sales_orders_status_ext.dart';

class SaleOrderCard extends StatelessWidget {
  const SaleOrderCard({
    Key? key,
    required this.saleOrder,
  }) : super(key: key);

  final SalesOrder saleOrder;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pedido: #${saleOrder.orderId}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        subtitle: Text(
          saleOrder.status.getStatus(),
          style: TextStyle(
            color: saleOrder.status.getColor(),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: saleOrder.items
            .map((product) => SaleOrderProductTile(
                  saleOrder: saleOrder,
                  product: product,
                ))
            .toList(),
      ),
    );
  }
}
