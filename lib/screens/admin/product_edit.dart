import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/app_bar.dart';
import 'package:virtual_store/components/spacers.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/screens/admin/components/images_form.dart';
import 'package:virtual_store/screens/admin/components/product_data_form.dart';
import 'package:virtual_store/screens/admin/components/sizes_form.dart';
import 'package:virtual_store/services/products_manager.dart';

class ProdutEdit extends StatelessWidget {
  ProdutEdit({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: buildAppBar(context: context, title: product.name),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            ImagesForm(product: product),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProductDataForm(product: product),
                  FormSizes(product: product),
                  SpacerHeight.h5(),
                  Consumer<ProductsManager>(
                    builder: (_, productManager, __) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            await productManager.saveProduct(product);
                            Get.back();
                          } else {
                            debugPrint('Nao valido!!!');
                          }
                        },
                        child: SizedBox(
                          height: 52,
                          child: Center(
                            child: productManager.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Salvar alterações',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
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
