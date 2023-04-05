import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/app_bar.dart';
import 'package:virtual_store/components/lateral_menu.dart';
import 'package:virtual_store/components/spacers.dart';
import 'package:virtual_store/screens/store/insert_store_screen.dart';
import 'package:virtual_store/services/stores_manager.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/extensions/mask_cellphone_ext.dart';
import 'package:url_launcher/url_launcher.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userIsAdmin = context.read<UserAccountmanager>().isAdmin;
    const styleContato = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
        appBar: buildAppBar(
          context: context,
          title: 'Stores',
          actions: [
            if (userIsAdmin)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: IconButton(
                    onPressed: () => Get.to(() => const InsertStore(),
                        fullscreenDialog: true, popGesture: true),
                    icon: const Icon(Icons.add)),
              ),
          ],
        ),
        drawer: const LateralMenu(),
        body: Consumer<StoresManager>(builder: (_, storesManager, __) {
          return ListView.builder(
            itemCount: storesManager.listOfStores.length,
            itemBuilder: (context, index) {
              final store = storesManager.listOfStores[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 180,
                    child: Image.network(
                      store.storeImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.storeName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Contato: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              MaskTextInputFormatter()
                                  .cellphoneMask()
                                  .maskText(store.storePhoneNumber),
                              style: styleContato,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                await launchUrl(Uri(
                                        scheme: 'tel',
                                        path: store.storePhoneNumber))
                                    .then((result) {
                                  if (!result) {
                                    Get.snackbar('Ligação para Loja',
                                        'Não foi possivel estabelecer a conexão!');
                                  }
                                });
                              },
                              icon: const Icon(Icons.phone),
                            ),
                          ],
                        ),
                        SpacerHeight.h10(),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }));
  }
}
