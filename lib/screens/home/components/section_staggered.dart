import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:virtual_store/models/section.dart';
import 'package:virtual_store/screens/home/components/section_header.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered({super.key, required this.section});

  final Section section;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section: section),
          MasonryGridView.count(
              crossAxisCount: 3,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: section.items.length,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              itemBuilder: (_, index) {
                return FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: section.items[index].image,
                  fit: BoxFit.cover,
                );
              }),
        ],
      ),
    );
  }
}
