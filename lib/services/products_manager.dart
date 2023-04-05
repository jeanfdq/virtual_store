import 'dart:io';

import 'package:flutter/material.dart';
import 'package:virtual_store/firebase/firebase_instaces.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/product_size.dart';
import 'package:virtual_store/utils/constants.dart';

class ProductsManager extends ChangeNotifier {
  final _db = Firebase.dbInstance();
  final _storage = Firebase.storageInstance();

  String _searchText = '';
  List<Product> _listOfProducts = [];
  Product? _productSelected;
  ProductSize? _productSizeSelected;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Product? get productSelected => _productSelected;
  set productSelected(Product? selected) {
    _productSelected = selected;
    notifyListeners();
  }

  ProductSize? get productSizeSelected => _productSizeSelected;
  bool get sizeSelected => _productSizeSelected != null;

  set productSizeSelected(ProductSize? selected) {
    _productSizeSelected = selected;
    notifyListeners();
  }

  ProductsManager() {
    _getAllProducts();
  }

  String get searchText => _searchText;
  set searchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  int get lengthListOfproducts => filteredlistOfProducts.length;

  List<Product> get filteredlistOfProducts {
    List<Product> filteredList = [];

    filteredList = _searchText.isEmpty
        ? _listOfProducts
        : _listOfProducts
            .where((product) => product.name
                .toLowerCase()
                .trim()
                .contains(_searchText.toLowerCase().trim()))
            .toList();

    return filteredList;
  }

  Future<void> _getAllProducts() async {
    _db.collection(kCollectionDBProducts).snapshots().listen((event) {
      _listOfProducts =
          event.docs.map((e) => Product.fromMap(e.data())).toList();

      if (productSizeSelected != null) {
        final tt = event.docChanges.map((e) => e.doc).single;
        productSizeSelected = Product.fromMap(tt.data() ?? {})
            .sizes
            .where((element) => element.name == productSizeSelected!.name)
            .single;
      }

      notifyListeners();
    });
  }

  Product? findproductById(String productId) {
    try {
      return _listOfProducts.firstWhere((element) => element.id == productId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  bool hasStock(String size, int quantity) {
    if (_productSizeSelected != null) {
      return _productSizeSelected!.name == size &&
          _productSizeSelected!.stock >= quantity;
    } else {
      return false;
    }
  }

  int get getProductStock => _productSizeSelected?.stock ?? 0;

  Future<void> saveProduct(Product product) async {
    final productId = product.id.isEmpty ? Product.getRandomId : product.id;
    List<String> images = [];

    isLoading = true;

    for (var element in product.newImages ?? []) {
      if (element is String) {
        images.add(element);
      }

      if (element is File) {
        final root = _storage.ref();
        final imageStorage = root
            .child('products')
            .child(DateTime.now().microsecondsSinceEpoch.toString());

        final task = imageStorage.putFile(element);

        final profileUrl = await (await task).ref.getDownloadURL();
        images.add(profileUrl);
      }
    }

    product.id = productId;
    product.images = images;
    _db.collection(kCollectionDBProducts).doc(productId).set(product.toMap());

    isLoading = false;
    notifyListeners();
  }
}
