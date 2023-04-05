import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtual_store/firebase/firebase_instaces.dart';
import 'package:virtual_store/models/sales_order.dart';
import 'package:virtual_store/models/user_account.dart';
import 'package:virtual_store/services/cart_manager.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class SalesOrderManager extends ChangeNotifier {
  final _db = Firebase.dbInstance();

  StreamSubscription? _subscription;

  UserAccount? userAccount;
  SalesOrder? _salesOrder;

  SalesOrder? get getSalesOrder => _salesOrder;

  List<SalesOrder> _listOfSalesOrder = [];

  List<SalesOrder> get listOfSalesOrder => _listOfSalesOrder;

  updateUserAccount(UserAccountmanager userManager) {
    userAccount = userManager.userData;
    if (userAccount != null) {
      _getAllSalesOrder();
    }
    notifyListeners();
  }

  void _getAllSalesOrder() {
    _subscription = _db
        .collection(kCollectionDBOrders)
        .where('orderUser', isEqualTo: userAccount?.id)
        .snapshots()
        .listen((snapshot) {
      _listOfSalesOrder.clear();
      _listOfSalesOrder =
          snapshot.docs.map((e) => SalesOrder.fromMap(e.data())).toList();
      notifyListeners();
    });
  }

  Future<void> sendOrder(CartManager cartManager) async {
    final salesOrder = SalesOrder.fromCartManager(cartManager);

    salesOrder.orderId = SalesOrder.generateOrderId().toString().trim();
    salesOrder.orderDate = DateTime.now();

    await _db
        .collection(kCollectionDBOrders)
        .doc(salesOrder.orderId)
        .set(salesOrder.toMap());

    await cartManager.clearCart();

    _salesOrder = salesOrder;

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
