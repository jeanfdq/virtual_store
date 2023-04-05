import 'dart:convert';

class ProductSize {
  String name;
  num price;
  int stock;
  ProductSize({
    required this.name,
    required this.price,
    required this.stock,
  });

  ProductSize copyWith({
    String? name,
    num? price,
    int? stock,
  }) {
    return ProductSize(
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }

  factory ProductSize.fromMap(Map<String, dynamic> map) {
    return ProductSize(
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      stock: map['stock']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSize.fromJson(String source) =>
      ProductSize.fromMap(json.decode(source));

  @override
  String toString() => 'ProductSize(name: $name, price: $price, stock: $stock)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductSize &&
        other.name == name &&
        other.price == price &&
        other.stock == stock;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ stock.hashCode;
}
