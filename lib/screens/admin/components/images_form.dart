import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/screens/admin/components/image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      // Colocar a lista de images direto o FormField acatará que os valores deverão ser sempre uma lista de string e não de Dynamic
      // Sempre importante no initialValue trabalhar com copia de uma lista, senão o state modificará a lista original
      initialValue: List.from(product.images),
      validator: (images) {
        if (images != null && images.isEmpty) {
          return 'Informe ao menos uma foto!';
        }
        return null;
      },
      builder: (state) {
        void imageSelected(File file) {
          state.value?.add(file);
          state.didChange(state.value);
        }

        // Iremos pegar a imagem do State e nao do product
        return Column(
          children: [
            CarouselSlider(
              items: state.value?.map<Widget>((image) {
                return Stack(
                  fit: StackFit.expand, // Para o conteudo do Stack se expandir
                  children: [
                    if (image is String)
                      Image.network(image, fit: BoxFit.cover),
                    if (image is File) Image.file(image, fit: BoxFit.cover),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            // Vamos remover a images do State e avisar o State que houve uma mudança para que ele chame o Build novamente
                            state.value?.remove(image);
                            state.didChange(state
                                .value); // Vai refazer o builder passando o novo state
                          },
                          child: const Text(
                            'remover',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList()
                // Adiciona mais um item no final da lista das Images por modo cascata "..add"
                ?..add(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (Platform.isAndroid) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => ImageSourceSheet(
                                      onImageSelected: imageSelected));
                            } else {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (_) => ImageSourceSheet(
                                      onImageSelected: imageSelected));
                            }
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Theme.of(context).primaryColor,
                            size: 36,
                          )),
                      Text(
                        'adiconar foto',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              options: CarouselOptions(
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  height: 300),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
          ],
        );
      },
      onSaved: (newValue) => product.newImages = newValue,
    );
  }
}
