import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({super.key, required this.onImageSelected});

  final Function(File) onImageSelected;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(onPressed: () {}, child: const Text('Camera')),
            TextButton(onPressed: () {}, child: const Text('Galeria')),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecione a foto.'),
        message: const Text('Escolha a origem da sua foto.'),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () async {
                final XFile? file =
                    await picker.pickImage(source: ImageSource.camera);
                if (file != null) {
                  editImage(file.path);
                }
              },
              child: const Text('Camera')),
          CupertinoActionSheetAction(
              onPressed: () async {
                final XFile? file =
                    await picker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  editImage(file.path);
                }
              },
              child: const Text('Galeria')),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar')),
      );
    }
  }

  void editImage(String imagePath) async {
    Get.back();
    final imageCropped = await ImageCropper.platform
        .cropImage(sourcePath: imagePath, uiSettings: [
      IOSUiSettings(
        showCancelConfirmationDialog: true,
        title: 'Edição de Images',
        doneButtonTitle: 'Confirmar',
        cancelButtonTitle: 'Cancelar',
      ),
      AndroidUiSettings(
        toolbarTitle: 'Edição de Images',
        toolbarColor: Get.theme.primaryColor,
      ),
    ]);
    if (imageCropped != null) {
      onImageSelected(File(imageCropped.path));
    }
  }
}

 // 20239002778260
 // nro caso (auditoria): 230315121985630 