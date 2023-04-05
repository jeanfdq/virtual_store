import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/firebase/firebase_errors.dart';
import 'package:virtual_store/firebase/firebase_instaces.dart';
import 'package:virtual_store/models/device.dart';
import 'package:virtual_store/models/user_account.dart';
import 'package:virtual_store/utils/constants.dart';

class UserAccountmanager extends ChangeNotifier {
  final _auth = Firebase.authInstance();
  final _db = Firebase.dbInstance();

  bool loading = false;
  User? currentUser;
  UserAccount? userData;

  bool _isAdmin = false;

  UserAccountmanager() {
    _loadCurrentUser();
  }

  _loadCurrentUser() {
    currentUser = _auth.currentUser;

    if (currentUser != null) {
      _loadUserData(currentUser!.uid);
      _verifyIsAdmin(currentUser!.uid);
    }

    notifyListeners();
  }

  _loadUserData(String uid) {
    _db.collection(kCollectionDBUsers).doc(uid).snapshots().listen((event) {
      userData = UserAccount.fromMap(event.data() ?? {});
      notifyListeners();
    });
  }

  _verifyIsAdmin(String uid) async {
    try {
      final snapshotAdmin =
          await _db.collection(kCollectionDBAdmins).doc(uid).get();
      if (snapshotAdmin.exists) {
        _isAdmin = true;
      } else {
        _isAdmin = false;
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool get isAdmin => _isAdmin;

  _setCurrentUser(User? user) async {
    currentUser = user;
  }

  Future<void> userLogout() async {
    _auth.signOut();
    _setCurrentUser(null);
    notifyListeners();
  }

  Future<void> userSignIn(
      {required UserAccount user,
      required String password,
      required Function onSucess,
      required Function onFail}) async {
    changeLoading();
    try {
      final firebaseUser = await _auth.signInWithEmailAndPassword(
          email: user.email, password: password);
      _setCurrentUser(firebaseUser.user);

      _loadCurrentUser();
      changeLoading();

      if (userData != null) {
        await saveDeviceId(userData!);
      }

      onSucess();
    } on FirebaseAuthException catch (e) {
      changeLoading();
      onFail(GetFirebaseErrors.authExceptionsMessage(e.code));
      debugPrint(GetFirebaseErrors.authExceptionsMessage(e.code));
    }

    return;
  }

  Future<void> createSigUp(
      {required UserAccount user,
      required String password,
      required Function onSucces,
      required Function onFail}) async {
    await createAuthWithEmailAndPassword(
      user: user,
      password: password,
      onSucces: (User? userFirebase) {
        if (userFirebase != null) {
          try {
            user.id = userFirebase.uid;
            _db.collection(kCollectionDBUsers).doc(user.id).set(user.toMap());
            _setCurrentUser(userFirebase);
            _loadCurrentUser();
            if (userData != null) {
              saveDeviceId(userData!);
            }
            onSucces();
          } on FirebaseException catch (e) {
            onFail(GetFirebaseErrors.createUserExceptionsMessage(e.code));
          }
        } else {
          onFail(GetFirebaseErrors.createUserExceptionsMessage(''));
        }
      },
      onFail: onFail,
    );
  }

  Future<void> createAuthWithEmailAndPassword(
      {required UserAccount user,
      required String password,
      required Function onSucces,
      required Function onFail}) async {
    final auth = Firebase.authInstance();
    changeLoading();
    try {
      final userCredencial = await auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      final userFirebase = userCredencial.user;
      if (userFirebase != null) {
        await userFirebase.updateDisplayName(user.name);
        _setCurrentUser(userFirebase);
      }
      changeLoading();
      onSucces(userFirebase);
    } on FirebaseAuthException catch (e) {
      changeLoading();
      onFail(GetFirebaseErrors.authExceptionsMessage(e.code));
    }
  }

  void changeLoading() {
    loading = !loading;
    notifyListeners();
  }

  Future<void> updateUserAccount(UserAccount userAccount) async {
    await _db
        .collection(kCollectionDBUsers)
        .doc(userAccount.id)
        .update(userAccount.toMap());
  }

  Future<void> saveDeviceId(UserAccount userAccount) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      final device = Device(
        userId: userAccount.id,
        deviceId: token,
        deviceIdUpdateAt: Timestamp.now(),
        devicePlatform: Platform.operatingSystem,
      );
      _db
          .collection(kCollectionDBDevices)
          .doc(userAccount.id)
          .set(device.toMap());
    }
  }
}
