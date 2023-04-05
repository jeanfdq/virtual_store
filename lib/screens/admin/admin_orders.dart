import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/app_bar.dart';
import 'package:virtual_store/components/lateral_menu.dart';
import 'package:virtual_store/screens/sales/components/sale_order_card.dart';
import 'package:virtual_store/services/admin_sales_order_manager.dart';

class AdminOrders extends StatelessWidget {
  const AdminOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'Admin - Pedidos'),
        drawer: const LateralMenu(),
        body: Consumer<AdminSalesOrdersManager>(
            builder: (_, adminSalesOrderManager, __) {
          return ListView.builder(
              itemCount: adminSalesOrderManager.listOfSalesOrder.length,
              itemBuilder: (_, index) {
                return SaleOrderCard(
                  saleOrder: adminSalesOrderManager.listOfSalesOrder.reversed
                      .toList()[index],
                );
              });
        }));
  }
}
