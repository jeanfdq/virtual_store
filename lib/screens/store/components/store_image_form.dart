import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:virtual_store/screens/admin/components/image_source_sheet.dart';
import 'package:virtual_store/utils/constants.dart';

class StoreImageForm extends StatelessWidget {
  StoreImageForm({
    Key? key,
    required this.onSelectedImage,
  }) : super(key: key);

  final Function(File?) onSelectedImage;

  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: images,
      validator: (images) {
        if (images != null) {
          if (images.isEmpty) {
            return 'Selecione ao menos uma imagem para a loja';
          }
        }
        return null;
      },
      builder: (state) {
        void imageSelected(File file) {
          state.value?.add(file);
          state.didChange(state.value);
        }

        return InkWell(
          onTap: () {
            if (Platform.isAndroid) {
              showModalBottomSheet(
                  context: context,
                  builder: (_) =>
                      ImageSourceSheet(onImageSelected: imageSelected));
            } else {
              showCupertinoModalPopup(
                  context: context,
                  builder: (_) =>
                      ImageSourceSheet(onImageSelected: imageSelected));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.value?.isEmpty ?? true)
                SizedBox(
                  height: 350,
                  child: Image.asset(
                    kImageNoPhoto,
                    fit: BoxFit.cover,
                  ),
                ),
              if (state.value?.isNotEmpty ?? false)
                SizedBox(
                    height: 350,
                    child: Image.file(state.value!.first, fit: BoxFit.cover)),
              if (state.hasError)
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 0, top: 16, bottom: 16),
                  child: Center(
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      onSaved: (newValue) {
        onSelectedImage(newValue?.first);
      },
    );
  }
}
