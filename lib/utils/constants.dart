import 'package:flutter/material.dart';
import 'package:virtual_store/screens/address/address_screen.dart';
import 'package:virtual_store/screens/cart/cart_screen.dart';
import 'package:virtual_store/screens/checkout/checkout_screen.dart';
import 'package:virtual_store/screens/home/home_screen.dart';
import 'package:virtual_store/screens/product/product_detail.dart';
import 'package:virtual_store/screens/sales/my_orders.dart';
import 'package:virtual_store/screens/admin/product_edit.dart';
import 'package:virtual_store/screens/product/produts_screen.dart';
import 'package:virtual_store/screens/splash/splash_screen.dart';
import 'package:virtual_store/screens/store/stores_screen.dart';
import 'package:virtual_store/screens/user/login.dart';
import 'package:virtual_store/screens/user/signup.dart';
import 'package:virtual_store/screens/user/user_logoff.dart';

Size getScreenSize(BuildContext context) => MediaQuery.of(context).size;

const kTokenCepAPI = '4f7a3eeaea7371f6a61eedf8075ffaff';

const kLogoAnimated = 'assets/lottie/store-animated.json';
const kCheckedAnimated = 'assets/lottie/checked-animated.json';

const kImagePerfilAvatar = 'assets/images/avatar.jpg';
const kImageNoPhoto = 'assets/images/no-photo.jpg';
const kDefaultPadding = 20.0;

const kCollectionDBHome = 'home';
const kCollectionDBAdmins = 'admins';
const kCollectionDBUsers = 'users';
const kCollectionDBProducts = 'products';
const kCollectionDBCart = 'cart';
const kCollectionDBDelivery = 'delivery';
const kCollectionDBOrders = 'salesOrders';
const kCollectionDBStores = 'stores';
const kCollectionDBDevices = 'devices';

// Routes Names ------------
enum RoutesNamed {
  splash,
  home,
  login,
  signup,
  products,
  myOrders,
  stores,
  logoff,
  productEdit,
  productDetail,
  cart,
  address,
  checkout,
  checkoutSaleOrderFinished
}

extension RoutesNamedExtension on RoutesNamed {
  String getRoutePath() {
    switch (this) {
      case RoutesNamed.home:
        return '/home';
      case RoutesNamed.login:
        return '/login';
      case RoutesNamed.signup:
        return '/signup';
      case RoutesNamed.products:
        return '/products';
      case RoutesNamed.myOrders:
        return '/myOrders';
      case RoutesNamed.stores:
        return '/stores';
      case RoutesNamed.logoff:
        return '/logoff';
      case RoutesNamed.productEdit:
        return '/productEdit';
      case RoutesNamed.productDetail:
        return '/productDetail';
      case RoutesNamed.cart:
        return '/cart';
      case RoutesNamed.address:
        return '/address';
      case RoutesNamed.checkout:
        return '/checkout';
      default:
        return '/';
    }
  }

  Widget Function(BuildContext) getRoute(BuildContext context) {
    switch (this) {
      case RoutesNamed.home:
        return (context) => const HomeScreen();
      case RoutesNamed.login:
        return (context) => Login();
      case RoutesNamed.signup:
        return (context) => SignUp();
      case RoutesNamed.products:
        return (context) => const ProductsScreen();
      case RoutesNamed.myOrders:
        return (context) => const MyOrders();
      case RoutesNamed.stores:
        return (context) => const StoresScreen();
      case RoutesNamed.logoff:
        return (context) => const UserLogoff();
      case RoutesNamed.productEdit:
        return (context) => ProdutEdit();
      case RoutesNamed.productDetail:
        return (context) => const ProductDetail();
      case RoutesNamed.cart:
        return (context) => const CartScreen();
      case RoutesNamed.address:
        return (context) => const AddressScreen();
      case RoutesNamed.checkout:
        return (context) => CheckoutScreen();
      default:
        return (context) => const SplashScreen();
    }
  }
}

// Paginas Lateral Menu-------------------------------------------
enum LateralPageName {
  home,
  produtos,
  pedidos,
  lojas,
  logoff,
  adminUsers,
  adminProduct,
  adminOrders
}

extension LateralPageNameExtension on LateralPageName {
  int getPageNumber() {
    switch (this) {
      case LateralPageName.home:
        return 0;
      case LateralPageName.produtos:
        return 1;
      case LateralPageName.pedidos:
        return 2;
      case LateralPageName.lojas:
        return 3;
      case LateralPageName.logoff:
        return 4;
      case LateralPageName.adminUsers:
        return 5;
      case LateralPageName.adminProduct:
        return 6;
      case LateralPageName.adminOrders:
        return 7;
      default:
        return 0;
    }
  }
}
// ---------------------------------------------------------------