import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:virtual_store/firebase/firebase_instaces.dart';
import 'package:virtual_store/models/address.dart';
import 'package:virtual_store/models/cart.dart';

import 'package:virtual_store/models/product_cart.dart';
import 'package:virtual_store/models/user_account.dart';
import 'package:virtual_store/services/api/cep_aberto_service.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class CartManager extends ChangeNotifier {
  final _auth = Firebase.authInstance();
  final _db = Firebase.dbInstance();

  List<ProductCart> _listOfProductCart = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  UserAccount? userAccount;

  ProductCart? _selectedProductCart;

  set selectedProductCart(ProductCart selected) {
    _selectedProductCart = selected;
  }

  bool hasStock(int quantity) {
    if (_selectedProductCart == null) {
      return false;
    } else {
      return _selectedProductCart!.stock > quantity;
    }
  }

  String _getUserId() => _auth.currentUser?.uid ?? '';

  void updateUser(UserAccountmanager userManager) {
    userAccount = userManager.userData;

    _listOfProductCart.clear();
  }

  List<ProductCart> get listOfProductCart {
    return _listOfProductCart;
  }

  CartManager() {
    _getListProductsDB();
  }

  Future<void> _getListProductsDB() async {
    final id = _getUserId();

    _db.collection(kCollectionDBCart).doc(id).snapshots().listen((event) {
      try {
        _listOfProductCart = Cart.fromMap(event.data() ?? {}).items;
        notifyListeners();
      } catch (e) {
        _listOfProductCart = [];

        notifyListeners();
      }
    });
  }

  void addProductCart(ProductCart productCart) async {
    final indexSizeProduct = _listOfProductCart.indexWhere((element) =>
        element.productId == productCart.productId &&
        element.size == productCart.size);

    if (indexSizeProduct >= 0) {
      int quantitySize = _listOfProductCart[_listOfProductCart.indexWhere(
              (element) =>
                  element.productId == productCart.productId &&
                  element.size == productCart.size)]
          .quantity;

      if (quantitySize > 0) {
        _listOfProductCart[indexSizeProduct].quantity = 1 + quantitySize;
      } else {
        _listOfProductCart.add(productCart);
      }
    } else {
      _listOfProductCart.add(productCart);
    }
    await updateCart();
    notifyListeners();
  }

  void removeProductCart(ProductCart productCart) async {
    final indexSizeProduct = _listOfProductCart.indexWhere((element) =>
        element.productId == productCart.productId &&
        element.size == productCart.size);

    int quantitySize = _listOfProductCart[indexSizeProduct].quantity - 1;

    if (quantitySize == 0) {
      _listOfProductCart.removeAt(indexSizeProduct);
    } else {
      _listOfProductCart[indexSizeProduct].quantity = quantitySize;
    }

    await updateCart();
    notifyListeners();
  }

  Future<void> updateCart() async {
    final userId = _getUserId();

    num totalItems = sumTotalProducts;

    final cart = Cart(
        userId: userId,
        items: _listOfProductCart,
        itemQuantity: sumTotalQuantityProducts,
        itemTotal: totalItems);

    _db.collection(kCollectionDBCart).doc(userAccount!.id).set(cart.toMap());
  }

  int get sumTotalQuantityProducts {
    int total = _listOfProductCart.fold(0, (p, c) => p + c.quantity);
    return total;
  }

  num get sumTotalProducts {
    num total =
        _listOfProductCart.fold(0, (p, c) => p + c.itemPrice * c.quantity);

    return total;
  }

  // Tratar a parte de Address

  double? _deliveryPrice;

  double get deliveryPrice => _deliveryPrice ?? 0;

  Address? _address;
  Address? get getAddress => _address;
  set setAddress(Address? value) {
    _address = value;
    notifyListeners();
  }

  Future<void> getAddressFromCep(String cep) async {
    try {
      setLoading = true;
      _address = await CepAbertoService().getAddressFromCep(cep);
      setLoading = false;
      notifyListeners();
    } catch (e) {
      setLoading = false;
      return Future.error(e.toString());
    }
  }

  void removeAddress() {
    _address = null;
    _deliveryPrice = 0;
    notifyListeners();
  }

  Future<void> calculateDelivery(double lat, double long) async {
    final snapshot =
        await _db.collection(kCollectionDBDelivery).doc('delivery').get();

    final storeLatitude = snapshot.data()?['lat'] as double;
    final storeLongitude = snapshot.data()?['long'] as double;

    double distance =
        Geolocator.distanceBetween(storeLatitude, storeLongitude, lat, long);

    // vamos converter a distancia em Km pois a api retorna em metros
    distance = distance / 1000;
    num valorBase = snapshot.data()?['basePrice'] as num;
    num priceKm = snapshot.data()?['kmPrice'] as num;

    _deliveryPrice = valorBase + (distance * priceKm);

    notifyListeners();
  }

  num get sumTotal {
    return sumTotalProducts + deliveryPrice;
  }

  Future<void> clearCart() async {
    await _db.collection(kCollectionDBCart).doc(_getUserId()).delete();
    _listOfProductCart.clear();
    notifyListeners();
  }
}
