import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:virtual_store/models/product_size.dart';

class Product {
  String id;
  String name;
  String description;
  List<String> images;
  List<ProductSize> sizes;
  List<dynamic>? newImages;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.sizes,
    this.newImages,
  });

  static String getRandomId = const Uuid().v4();

  num get basePrice {
    // Vamos percorrer todos os tamanho e encontrar o menor preço
    double lowestPrice = double.infinity;
    for (var size in sizes) {
      if (size.price < lowestPrice) {
        lowestPrice = size.price.toDouble();
      }
    }
    return lowestPrice;
  }

  ProductSize getSize(String sizename) {
    try {
      return sizes.firstWhere((element) => element.name == sizename);
    } catch (e) {
      return ProductSize(name: '', price: 0, stock: 0);
    }
  }

  static Product createEmpty() => Product(
      id: '', name: '', description: '', images: [], sizes: [], newImages: []);

  Product copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? images,
    List<ProductSize>? sizes,
    List<dynamic>? newImages,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      newImages: newImages ?? this.newImages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'sizes': sizes.map((x) => x.toMap()).toList()
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        images: List<String>.from(map['images']),
        sizes: List<ProductSize>.from(
            map['sizes']?.map((x) => ProductSize.fromMap(x))));
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        listEquals(other.images, images) &&
        listEquals(other.sizes, sizes) &&
        listEquals(other.newImages, newImages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        images.hashCode ^
        sizes.hashCode ^
        newImages.hashCode;
  }
}
