import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/product_size.dart';
import 'package:virtual_store/services/products_manager.dart';

class ProductSizeWidget extends StatelessWidget {
  const ProductSizeWidget({
    super.key,
    required this.size,
  });

  final ProductSize size;

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.theme.primaryColor;
    final produtManager = context.watch<ProductsManager>();
    bool sizeSelected = produtManager.productSizeSelected == size;

    return InkWell(
      onTap: () {
        if (size.stock > 0) {
          produtManager.productSizeSelected = size;
        }
      },
      child: Container(
        height: 32,
        width: 140,
        decoration: BoxDecoration(
          border: Border.all(
              color: size.stock > 0
                  ? sizeSelected
                      ? primaryColor
                      : Colors.grey
                  : Colors.redAccent),
        ),
        child: Row(
          children: [
            Container(
              color: size.stock > 0
                  ? sizeSelected
                      ? primaryColor
                      : Colors.grey.shade400
                  : Colors.redAccent.shade100,
              height: 32,
              width: 40,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Center(
                child: Text(
                  size.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 32,
                child: Center(
                    child: Text(
                  'R\$ ${size.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
