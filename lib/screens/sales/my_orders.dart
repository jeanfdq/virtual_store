import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/app_bar.dart';
import 'package:virtual_store/components/lateral_menu.dart';
import 'package:virtual_store/screens/sales/components/sale_order_card.dart';
import 'package:virtual_store/services/sales_order_manager.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'My Orders'),
      drawer: const LateralMenu(),
      body: Consumer<SalesOrderManager>(
        builder: (context, salesManager, child) {
          if (salesManager.userAccount != null) {
            if (salesManager.listOfSalesOrder.isEmpty) {
              return Center(
                child: Icon(
                  Icons.extension,
                  size: 72,
                  color: Get.theme.primaryColor,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: salesManager.listOfSalesOrder.length,
                  itemBuilder: (_, idx) {
                    return SaleOrderCard(
                      saleOrder:
                          salesManager.listOfSalesOrder.reversed.toList()[idx],
                    );
                  });
            }
          } else {
            return const Center(
              child: Icon(
                Icons.warning,
                size: 86,
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
