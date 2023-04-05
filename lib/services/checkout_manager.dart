import 'package:flutter/material.dart';
import 'package:virtual_store/models/sales_order.dart';
import 'package:virtual_store/services/sales_order_manager.dart';

class CheckoutManager extends ChangeNotifier {
  SalesOrder? _salesOrder;

  SalesOrder? get getSalesOrder => _salesOrder;

  updateSalesOrder(SalesOrderManager salesOrderManager) {
    _salesOrder = salesOrderManager.getSalesOrder;
    notifyListeners();
  }
}
