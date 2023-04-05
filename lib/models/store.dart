import 'dart:convert';

import 'package:uuid/uuid.dart';

class Store {
  String storeId;
  String storeName;
  String storeImage;
  String storePhoneNumber;
  Store({
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.storePhoneNumber,
  });

  factory Store.storeEmpty() {
    return Store(
        storeId: const Uuid().v4(),
        storeName: '',
        storeImage: '',
        storePhoneNumber: '');
  }

  Store copyWith({
    String? storeId,
    String? storeName,
    String? storeImage,
    String? storePhoneNumber,
  }) {
    return Store(
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeImage: storeImage ?? this.storeImage,
      storePhoneNumber: storePhoneNumber ?? this.storePhoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'storeName': storeName,
      'storeImage': storeImage,
      'storePhoneNumber': storePhoneNumber,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      storeId: map['storeId'] ?? '',
      storeName: map['storeName'] ?? '',
      storeImage: map['storeImage'] ?? '',
      storePhoneNumber: map['storePhoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) => Store.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Store(storeId: $storeId, storeName: $storeName, storeImage: $storeImage, storePhoneNumber: $storePhoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Store &&
        other.storeId == storeId &&
        other.storeName == storeName &&
        other.storeImage == storeImage &&
        other.storePhoneNumber == storePhoneNumber;
  }

  @override
  int get hashCode {
    return storeId.hashCode ^
        storeName.hashCode ^
        storeImage.hashCode ^
        storePhoneNumber.hashCode;
  }
}
