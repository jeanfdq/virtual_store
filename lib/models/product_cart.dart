import 'dart:convert';

import 'package:virtual_store/models/product.dart';

class ProductCart {
  String productId;
  int quantity;
  String size;
  num price;
  Product product;
  int stock;
  ProductCart({
    required this.productId,
    required this.quantity,
    required this.size,
    required this.price,
    required this.product,
    required this.stock,
  });

  num get itemPrice => price;

  bool get hasStock => quantity <= stock;

  ProductCart copyWith({
    String? productId,
    int? quantity,
    String? size,
    num? price,
    Product? product,
    int? stock,
  }) {
    return ProductCart(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      price: price ?? this.price,
      product: product ?? this.product,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'size': size,
      'price': price,
      'product': product.toMap(),
      'stock': stock,
    };
  }

  factory ProductCart.fromMap(Map<String, dynamic> map) {
    return ProductCart(
      productId: map['productId'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      size: map['size'] ?? '',
      price: map['price'] ?? 0,
      product: Product.fromMap(map['product']),
      stock: map['stock']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCart.fromJson(String source) =>
      ProductCart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductCart(productId: $productId, quantity: $quantity, size: $size, price: $price, product: $product, stock: $stock)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductCart &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.size == size &&
        other.price == price &&
        other.product == product &&
        other.stock == stock;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        quantity.hashCode ^
        size.hashCode ^
        price.hashCode ^
        product.hashCode ^
        stock.hashCode;
  }
}
