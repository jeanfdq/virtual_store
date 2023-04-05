import 'dart:convert';

class SectionItem {
  String product;
  String image;
  SectionItem({
    required this.product,
    required this.image,
  });

  SectionItem copyWith({
    String? product,
    String? image,
  }) {
    return SectionItem(
      product: product ?? this.product,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'image': image,
    };
  }

  factory SectionItem.fromMap(Map<String, dynamic> map) {
    return SectionItem(
      product: map['product'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SectionItem.fromJson(String source) =>
      SectionItem.fromMap(json.decode(source));

  @override
  String toString() => 'SectionItem(product: $product, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SectionItem &&
        other.product == product &&
        other.image == image;
  }

  @override
  int get hashCode => product.hashCode ^ image.hashCode;
}
