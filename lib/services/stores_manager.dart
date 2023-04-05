import 'dart:io';

import 'package:flutter/material.dart';
import 'package:virtual_store/firebase/firebase_instaces.dart';
import 'package:virtual_store/models/store.dart';
import 'package:virtual_store/utils/constants.dart';

class StoresManager extends ChangeNotifier {
  final _db = Firebase.dbInstance();
  final _storage = Firebase.storageInstance();

  List<Store> _listOfSores = [];

  List<Store> get listOfStores => _listOfSores;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  StoresManager() {
    _getAllStores();
  }

  void _getAllStores() {
    _setLoading(true);
    _db.collection(kCollectionDBStores).snapshots().listen((snapshot) {
      _listOfSores = snapshot.docs.map((e) => Store.fromMap(e.data())).toList();
      _setLoading(false);
      notifyListeners();
    });
  }

  Future<bool> createStore(Store store, File storeImage) async {
    try {
      _setLoading(true);
      final root = _storage.ref();
      final imageStorage = root
          .child('stores')
          .child(DateTime.now().microsecondsSinceEpoch.toString());
      final task = imageStorage.putFile(storeImage);

      store.storeImage = await (await task).ref.getDownloadURL();

      await _db
          .collection(kCollectionDBStores)
          .doc(store.storeId)
          .set(store.toMap());
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }
}
