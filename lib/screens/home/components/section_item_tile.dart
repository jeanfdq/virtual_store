import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:virtual_store/models/section_item.dart';
import 'package:virtual_store/services/products_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class SectionItemTile extends StatelessWidget {
  const SectionItemTile({super.key, required this.sectionItem});

  final SectionItem sectionItem;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          final product = context
              .read<ProductsManager>()
              .findproductById(sectionItem.product);
          if (product != null) {
            Navigator.pushNamed(
                context, RoutesNamed.productDetail.getRoutePath(),
                arguments: product);
          }
        },
        child: AspectRatio(
            aspectRatio: 1,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: sectionItem.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
