import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
  });

  final String imageUrl;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageUrl,
              width: 150,
              fit: BoxFit.cover,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      productName,
                      style: const TextStyle(
                          overflow: TextOverflow.clip, fontSize: 24),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
