import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:virtual_store/models/section_item.dart';

class Section {
  String name;
  String type;
  List<SectionItem> items;
  Section({
    required this.name,
    required this.type,
    required this.items,
  });

  Section copyWith({
    String? name,
    String? type,
    List<SectionItem>? items,
  }) {
    return Section(
      name: name ?? this.name,
      type: type ?? this.type,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      items: List<SectionItem>.from(
          map['items']?.map((x) => SectionItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Section.fromJson(String source) =>
      Section.fromMap(json.decode(source));

  @override
  String toString() => 'Section(name: $name, type: $type, items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Section &&
        other.name == name &&
        other.type == type &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode ^ items.hashCode;
}
