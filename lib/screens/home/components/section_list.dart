import 'package:flutter/material.dart';
import 'package:virtual_store/models/section.dart';
import 'package:virtual_store/screens/home/components/section_header.dart';
import 'package:virtual_store/screens/home/components/section_item_tile.dart';

class SectionList extends StatelessWidget {
  const SectionList({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section: section),
          SizedBox(
            height: 150,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return SectionItemTile(sectionItem: section.items[index]);
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(
                    width: 6,
                  );
                },
                itemCount: section.items.length),
          ),
        ],
      ),
    );
  }
}
