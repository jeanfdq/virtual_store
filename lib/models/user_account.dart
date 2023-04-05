import 'dart:convert';

import 'package:virtual_store/models/address.dart';

class UserAccount {
  String id;
  String name;
  String email;
  String phone;
  bool isAdmin;
  Address? address;
  UserAccount({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.isAdmin,
    this.address,
  });

  UserAccount copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    bool? isAdmin,
    Address? address,
  }) {
    return UserAccount(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isAdmin: isAdmin ?? this.isAdmin,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isAdmin': isAdmin,
      'address': address?.toJson(),
    };
  }

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      address: map['address'] != null ? Address.fromJson(map['address']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAccount.fromJson(String source) =>
      UserAccount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserAccount(id: $id, name: $name, email: $email, phone: $phone, isAdmin: $isAdmin, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAccount &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.isAdmin == isAdmin &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        isAdmin.hashCode ^
        address.hashCode;
  }
}
