import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/firebase/firebase_instaces.dart';
import 'package:virtual_store/models/section.dart';
import 'package:virtual_store/utils/constants.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadAllSections();
  }

  final FirebaseFirestore _db = Firebase.dbInstance();
  List<Section> sections = [];

  Future<void> _loadAllSections() async {
    sections.clear();
    _db.collection(kCollectionDBHome).snapshots().listen((snapshot) {
      sections = snapshot.docs.map((e) => Section.fromMap(e.data())).toList();
      notifyListeners();
    });
  }
}
