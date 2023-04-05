import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtual_store/firebase/firebase_instaces.dart';
import 'package:virtual_store/models/sales_order.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class AdminSalesOrdersManager extends ChangeNotifier {
  final _db = Firebase.dbInstance();

  StreamSubscription? _subscription;

  List<SalesOrder> _listOfSalesOrder = [];

  List<SalesOrder> get listOfSalesOrder => _listOfSalesOrder;

  updateUserAccount(UserAccountmanager userManager) {
    final userAccount = userManager.userData;
    if (userAccount != null && userAccount.isAdmin) {
      _getListOfSalesOrder();
    }
    notifyListeners();
  }

  void _getListOfSalesOrder() async {
    _listOfSalesOrder.clear();
    _subscription = _db
        .collection(kCollectionDBOrders)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .listen((snapshot) {
      _listOfSalesOrder =
          snapshot.docs.map((e) => SalesOrder.fromMap(e.data())).toList();
      notifyListeners();
    });
  }

  Future<bool> cancelSaleOrder(SalesOrder salesOrder) async {
    try {
      _db
          .collection(kCollectionDBOrders)
          .doc(salesOrder.orderId)
          .update(salesOrder.toMap());
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
