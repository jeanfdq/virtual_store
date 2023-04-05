import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/store.dart';
import 'package:virtual_store/screens/store/components/store_data_form.dart';
import 'package:virtual_store/screens/store/components/store_image_form.dart';
import 'package:virtual_store/services/stores_manager.dart';

class InsertStore extends StatelessWidget {
  const InsertStore({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    File? storeImage;
    String storeName = '';
    String storePhoneNumber = '';
    Store store = Store.storeEmpty();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.close)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StoreImageForm(onSelectedImage: (image) {
                storeImage = image;
              }),
              StoreDataForm(
                store: store,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        final isCreated = await context
                            .read<StoresManager>()
                            .createStore(store, storeImage!);
                        if (isCreated) {
                          Get.back();
                        }
                      }
                    },
                    child: SizedBox(
                      height: 44,
                      child: Center(
                        child: Consumer<StoresManager>(
                          builder: (_, storeManager, __) {
                            return storeManager.isLoading
                                ? const LinearProgressIndicator()
                                : const Text(
                                    'Criar a loja',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                          },
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
