import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Firebase {
  static FirebaseFirestore dbInstance() => FirebaseFirestore.instance;
  static FirebaseAuth authInstance() => FirebaseAuth.instance;
  static FirebaseStorage storageInstance() => FirebaseStorage.instance;
}
