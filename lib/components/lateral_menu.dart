import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/dialog.dart';
import 'package:virtual_store/components/lateral_menu_header.dart';
import 'package:virtual_store/components/lateral_menu_items.dart';
import 'package:virtual_store/components/page_manager.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class LateralMenu extends StatelessWidget {
  const LateralMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = getScreenSize(context);
    return Consumer<UserAccountmanager>(
      builder: (context, userManager, child) => Drawer(
        elevation: 2,
        width: size.width * 0.7,
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              LateralMenuHeader(userManager: userManager),
              const BuildLateralMenuItems(
                page: LateralPageName.home,
                icon: Icons.home,
                title: 'Home',
              ),
              const BuildLateralMenuItems(
                page: LateralPageName.produtos,
                icon: Icons.list,
                title: 'Produtos',
              ),
              const BuildLateralMenuItems(
                page: LateralPageName.pedidos,
                icon: Icons.playlist_add_check,
                title: 'Meus Pedidos',
              ),
              const BuildLateralMenuItems(
                page: LateralPageName.lojas,
                icon: Icons.location_on,
                title: 'Lojas',
              ),
              userManager.isAdmin
                  ? const BuildLateralMenuItems(
                      page: LateralPageName.adminUsers,
                      icon: Icons.recent_actors,
                      title: 'Adm - Usuários',
                    )
                  : Container(),
              userManager.isAdmin
                  ? const BuildLateralMenuItems(
                      page: LateralPageName.adminProduct,
                      icon: Icons.category,
                      title: 'Adm - Produtos',
                    )
                  : Container(),
              userManager.isAdmin
                  ? const BuildLateralMenuItems(
                      page: LateralPageName.adminOrders,
                      icon: Icons.list_alt,
                      title: 'Adm - Pedidos',
                    )
                  : Container(),
              BuildLateralMenuItems(
                page: LateralPageName.logoff,
                icon: Icons.logout,
                title: 'sair da conta',
                action: () {
                  context.showDialog(
                    title: 'Log Out',
                    text: 'Deseja realmente sair conta?',
                    onConfirmText: 'Sim',
                    onConfirm: () {
                      context.read<PageManager>().goToPage(0);
                      userManager.userLogout();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, RoutesNamed.login.getRoutePath());
                    },
                    onCancelText: 'Não',
                    onCancel: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
