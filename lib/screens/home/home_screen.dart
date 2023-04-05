import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/page_manager.dart';
import 'package:virtual_store/screens/admin/admin_orders.dart';
import 'package:virtual_store/screens/admin/admin_products.dart';
import 'package:virtual_store/screens/admin/admin_users.dart';
import 'package:virtual_store/screens/home/body_home.dart';
import 'package:virtual_store/screens/product/produts_screen.dart';
import 'package:virtual_store/screens/sales/my_orders.dart';
import 'package:virtual_store/screens/store/stores_screen.dart';
import 'package:virtual_store/screens/user/user_logoff.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider<PageManager>(
      create: (context) => PageManager(_pageController),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          BodyHome(),
          ProductsScreen(),
          MyOrders(),
          StoresScreen(),
          UserLogoff(),
          AdminUsers(),
          AdminProducts(),
          AdminOrders()
        ],
      ),
    );
  }
}
