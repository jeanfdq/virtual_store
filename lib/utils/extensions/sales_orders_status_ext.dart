import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_store/models/sales_order.dart';

extension SalesOrdersStatusString on SaleOrderStatus {
  String getStatus() {
    switch (this) {
      case SaleOrderStatus.preparing:
        return 'Em preparação';
      case SaleOrderStatus.transporting:
        return 'Em transporte';
      case SaleOrderStatus.delivered:
        return 'Entregue';
      default:
        return 'Cancelado';
    }
  }
}

extension SalesOrdersStatusColor on SaleOrderStatus {
  Color getColor() {
    switch (this) {
      case SaleOrderStatus.preparing:
        return Get.theme.primaryColor;
      case SaleOrderStatus.transporting:
        return Get.theme.primaryColor;
      case SaleOrderStatus.delivered:
        return Colors.green;
      case SaleOrderStatus.canceled:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
