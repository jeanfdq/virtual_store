import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtual_store/firebase/firebase_instaces.dart';
import 'package:virtual_store/models/user_account.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class AdminUsersManager extends ChangeNotifier {
  StreamSubscription? _subscription;
  List<UserAccount> _listOfUsers = [];

  updateUserManager(UserAccountmanager userAccountManager) {
    // Esse cancel para quando há mudança de usuário o
    // listen do Snapshot do Firebase nao ficar baixando e comendo dados desnecessario
    _subscription?.cancel();

    if (userAccountManager.isAdmin) {
      _listenUsersDB();
      // final faker = Faker();
      // for (var i = 0; i < 100; i++) {
      //   final user = UserAccount(
      //       id: const Uuid().v4(),
      //       name: faker.person.name(),
      //       email: faker.internet.email(),
      //       phone: faker.phoneNumber.toString(),
      //       isAdmin: false);
      //   _listOfUsers.add(user);
      //   _listOfUsers.sort(
      //       (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      // }
      // notifyListeners();
    } else {
      _listOfUsers.clear();
      notifyListeners();
    }
  }

  List<UserAccount> get listOfUsers => _listOfUsers;
  List<String> get listOfNames => _listOfUsers.map((e) => e.name).toList();

  void _listenUsersDB() {
    final db = Firebase.dbInstance();
    _subscription =
        db.collection(kCollectionDBUsers).snapshots().listen((snapshot) {
      _listOfUsers =
          snapshot.docs.map((e) => UserAccount.fromMap(e.data())).toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
