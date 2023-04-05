import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_store/firebase/firebase_initialize.dart';
import 'package:virtual_store/services/admin_sales_order_manager.dart';
import 'package:virtual_store/services/admin_users_manager.dart';
import 'package:virtual_store/services/stores_manager.dart';
import 'package:virtual_store/services/cart_manager.dart';
import 'package:virtual_store/services/checkout_manager.dart';
import 'package:virtual_store/services/home_manager.dart';
import 'package:virtual_store/services/products_manager.dart';
import 'package:virtual_store/services/sales_order_manager.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  runApp(const VirtualStoreApp());
}

class VirtualStoreApp extends StatelessWidget {
  const VirtualStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeManager>(
          create: (context) => HomeManager(),
        ),
        ChangeNotifierProvider<StoresManager>(
          create: (context) => StoresManager(),
        ),
        ChangeNotifierProvider<UserAccountmanager>(
          create: (context) => UserAccountmanager(),
        ),
        ChangeNotifierProvider<ProductsManager>(
          create: (context) => ProductsManager(),
        ),
        /* o ProxyProvider serve para notificar uma classe quando outra for alterada que nesse caso
            que nesse caso quano o susuário logado for mudado a lista de compras do carrinho tem que ser resetada ou 
            buscada no Firebse do usuário que logou, ou seja, quando o userManager sofrer qualquer alteraçao ele 
            notificará o CartManager*/
        ChangeNotifierProxyProvider<UserAccountmanager, CartManager>(
          create: (_) => CartManager(),
          update: (_, userManager, cartManager) =>
              cartManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserAccountmanager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          update: (_, userAccountManager, adminUsersManager) =>
              adminUsersManager!..updateUserManager(userAccountManager),
        ),
        ChangeNotifierProxyProvider<UserAccountmanager, SalesOrderManager>(
          create: (_) => SalesOrderManager(),
          update: (_, userAccountManager, orderManager) =>
              orderManager!..updateUserAccount(userAccountManager),
        ),
        ChangeNotifierProxyProvider<SalesOrderManager, CheckoutManager>(
          create: (_) => CheckoutManager(),
          update: (_, salesOrderManager, checkoutManager) =>
              checkoutManager!..updateSalesOrder(salesOrderManager),
        ),
        ChangeNotifierProxyProvider<UserAccountmanager,
            AdminSalesOrdersManager>(
          create: (_) => AdminSalesOrdersManager(),
          update: (_, userAccountManager, adminSalesOrderManager) =>
              adminSalesOrderManager!..updateUserAccount(userAccountManager),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        initialRoute: RoutesNamed.splash.getRoutePath(),
        routes: {
          RoutesNamed.splash.getRoutePath():
              RoutesNamed.splash.getRoute(context),
          RoutesNamed.home.getRoutePath(): RoutesNamed.home.getRoute(context),
          RoutesNamed.login.getRoutePath(): RoutesNamed.login.getRoute(context),
          RoutesNamed.signup.getRoutePath():
              RoutesNamed.signup.getRoute(context),
          RoutesNamed.products.getRoutePath():
              RoutesNamed.products.getRoute(context),
          RoutesNamed.myOrders.getRoutePath():
              RoutesNamed.myOrders.getRoute(context),
          RoutesNamed.logoff.getRoutePath():
              RoutesNamed.logoff.getRoute(context),
          RoutesNamed.productEdit.getRoutePath():
              RoutesNamed.productEdit.getRoute(context),
          RoutesNamed.productDetail.getRoutePath():
              RoutesNamed.productDetail.getRoute(context),
          RoutesNamed.cart.getRoutePath(): RoutesNamed.cart.getRoute(context),
          RoutesNamed.address.getRoutePath():
              RoutesNamed.address.getRoute(context),
          RoutesNamed.checkout.getRoutePath():
              RoutesNamed.checkout.getRoute(context),
        },
      ),
    );
  }
}
