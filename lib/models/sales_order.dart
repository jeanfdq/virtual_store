import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:virtual_store/models/address.dart';
import 'package:virtual_store/models/product_cart.dart';
import 'package:virtual_store/services/cart_manager.dart';

enum SaleOrderStatus { canceled, preparing, transporting, delivered }

class SalesOrder {
  late String orderId;
  late DateTime orderDate;
  late num orderTotal;
  late String orderUser;
  late List<ProductCart> items;
  late Address orderAddress;
  late SaleOrderStatus status;
  SalesOrder({
    required this.orderId,
    required this.orderDate,
    required this.orderTotal,
    required this.orderUser,
    required this.items,
    required this.orderAddress,
    required this.status,
  });

  static int generateOrderId() {
    var random = Random();
    return random.nextInt(10000);
  }

  SalesOrder.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.listOfProductCart);
    orderTotal = num.parse(cartManager.sumTotal.toStringAsFixed(2));
    orderUser = cartManager.userAccount?.id ?? '';
    orderAddress = cartManager.getAddress ?? Address.empty();
    status = SaleOrderStatus.preparing;
  }

  SalesOrder copyWith({
    String? orderId,
    DateTime? orderDate,
    num? orderTotal,
    String? orderUser,
    List<ProductCart>? items,
    Address? orderAddress,
    SaleOrderStatus? status,
  }) {
    return SalesOrder(
      orderId: orderId ?? this.orderId,
      orderDate: orderDate ?? this.orderDate,
      orderTotal: orderTotal ?? this.orderTotal,
      orderUser: orderUser ?? this.orderUser,
      items: items ?? this.items,
      orderAddress: orderAddress ?? this.orderAddress,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'orderDate': orderDate.millisecondsSinceEpoch,
      'orderTotal': orderTotal,
      'orderUser': orderUser,
      'items': items.map((x) => x.toMap()).toList(),
      'orderAddress': orderAddress.toJson(),
      'status': status.name.toString(),
    };
  }

  factory SalesOrder.fromMap(Map<String, dynamic> map) {
    return SalesOrder(
      orderId: map['orderId'] ?? '',
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate']),
      orderTotal: map['orderTotal'] ?? 0,
      orderUser: map['orderUser'] ?? '',
      items: List<ProductCart>.from(
          map['items']?.map((x) => ProductCart.fromMap(x))),
      orderAddress: Address.fromJson(map['orderAddress']),
      status: SaleOrderStatus.values.byName(map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesOrder.fromJson(String source) =>
      SalesOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalesOrder(orderId: $orderId, orderDate: $orderDate, orderTotal: $orderTotal, orderUser: $orderUser, items: $items, orderAddress: $orderAddress, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SalesOrder &&
        other.orderId == orderId &&
        other.orderDate == orderDate &&
        other.orderTotal == orderTotal &&
        other.orderUser == orderUser &&
        listEquals(other.items, items) &&
        other.orderAddress == orderAddress &&
        other.status == status;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        orderDate.hashCode ^
        orderTotal.hashCode ^
        orderUser.hashCode ^
        items.hashCode ^
        orderAddress.hashCode ^
        status.hashCode;
  }
}
