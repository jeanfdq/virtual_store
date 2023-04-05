import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/lateral_menu.dart';
import 'package:virtual_store/screens/cart/cart_screen.dart';
import 'package:virtual_store/screens/checkout/checkout_screen.dart';
import 'package:virtual_store/screens/home/components/section_list.dart';
import 'package:virtual_store/screens/home/components/section_staggered.dart';
import 'package:virtual_store/services/cart_manager.dart';
import 'package:virtual_store/services/home_manager.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeManager>();

    return Scaffold(
        drawer: const LateralMenu(),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorLight,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            CustomScrollView(
              slivers: [
                SliverAppBar.medium(
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Virtual Store',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          if (context.read<CartManager>().deliveryPrice > 0) {
                            Get.to(() => CheckoutScreen(),
                                fullscreenDialog: true);
                          } else {
                            Get.to(() => const CartScreen(),
                                fullscreenDialog: true);
                          }
                        },
                        icon: const Icon(Icons.shopping_cart))
                  ],
                ),
                Consumer<HomeManager>(builder: (_, homeManager, __) {
                  final List<Widget> children =
                      homeManager.sections.map<Widget>((section) {
                    switch (section.type) {
                      case 'List':
                        return SectionList(section: section);

                      case 'Staggered':
                        return SectionStaggered(section: section);

                      default:
                        return Container();
                    }
                  }).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                }),
              ],
            ),
          ],
        ));
  }
}
