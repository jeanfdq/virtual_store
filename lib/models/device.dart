import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Device {
  final String userId;
  final String deviceId;
  final Timestamp deviceIdUpdateAt;
  final String devicePlatform;
  Device({
    required this.userId,
    required this.deviceId,
    required this.deviceIdUpdateAt,
    required this.devicePlatform,
  });

  Device copyWith({
    String? userId,
    String? deviceId,
    Timestamp? deviceIdUpdateAt,
    String? devicePlatform,
  }) {
    return Device(
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      deviceIdUpdateAt: deviceIdUpdateAt ?? this.deviceIdUpdateAt,
      devicePlatform: devicePlatform ?? this.devicePlatform,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'deviceId': deviceId,
      'deviceIdUpdateAt': deviceIdUpdateAt,
      'devicePlatform': devicePlatform,
    };
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      userId: map['userId'] ?? '',
      deviceId: map['deviceId'] ?? '',
      deviceIdUpdateAt: map['deviceIdUpdateAt'],
      devicePlatform: map['devicePlatform'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Device(userId: $userId, deviceId: $deviceId, deviceIdUpdateAt: $deviceIdUpdateAt, devicePlatform: $devicePlatform)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Device &&
        other.userId == userId &&
        other.deviceId == deviceId &&
        other.deviceIdUpdateAt == deviceIdUpdateAt &&
        other.devicePlatform == devicePlatform;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        deviceId.hashCode ^
        deviceIdUpdateAt.hashCode ^
        devicePlatform.hashCode;
  }
}
