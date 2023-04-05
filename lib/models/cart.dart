import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:virtual_store/models/product_cart.dart';

class Cart {
  String userId;
  List<ProductCart> items;
  int itemQuantity;
  num itemTotal;
  Cart({
    required this.userId,
    required this.items,
    required this.itemQuantity,
    required this.itemTotal,
  });

  int get totalQuantityItem => items.fold(0, (p, c) => p + c.quantity);

  Cart copyWith({
    String? userId,
    List<ProductCart>? items,
    int? itemQuantity,
    num? itemTotal,
  }) {
    return Cart(
      userId: userId ?? this.userId,
      items: items ?? this.items,
      itemQuantity: itemQuantity ?? this.itemQuantity,
      itemTotal: itemTotal ?? this.itemTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((x) => x.toMap()).toList(),
      'itemQuantity': itemQuantity,
      'itemTotal': itemTotal,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      userId: map['userId'] ?? '',
      items: List<ProductCart>.from(
          map['items']?.map((x) => ProductCart.fromMap(x))),
      itemQuantity: map['itemQuantity']?.toInt() ?? 0,
      itemTotal: map['itemTotal'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cart(userId: $userId, items: $items, itemQuantity: $itemQuantity, itemTotal: $itemTotal)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.userId == userId &&
        listEquals(other.items, items) &&
        other.itemQuantity == itemQuantity &&
        other.itemTotal == itemTotal;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        items.hashCode ^
        itemQuantity.hashCode ^
        itemTotal.hashCode;
  }
}
