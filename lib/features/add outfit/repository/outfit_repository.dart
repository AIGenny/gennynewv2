import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../models/models.dart' show OutfitModel;

final outfitReposityProvider = Provider<OutfitReposity>(
      (ref) => OutfitReposity(
      firebaseStorage: ref.read(storageProvider),
      firestore: ref.read(firestoreProvider),
      uid: ref.read(authProvider).currentUser!.uid),
);

class OutfitReposity {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  final String _uid;

  OutfitReposity(
      {required FirebaseFirestore firestore,
        required String uid,
        required FirebaseStorage firebaseStorage})
      : _firestore = firestore,
        _firebaseStorage = firebaseStorage,
        _uid = uid;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  DocumentReference get _userDoc => _users.doc(_uid);

  CollectionReference get _outfitCollection =>
      _userDoc.collection(FirebaseConstants.outfitCollection);

  Future<String?> uploadImage( File file, String name) async {

    final imageRef = _firebaseStorage.ref().child("outfits").child("$name.jpg");
    try {
      await imageRef.putFile(file!);
      final String url = await imageRef.getDownloadURL();
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> uploadImageFromFile(File file, String name) async {
    final imageRef = _firebaseStorage.ref().child("outfits").child("$name.jpg");
    try {
      await imageRef.putFile(file);
      final String url = await imageRef.getDownloadURL();
      return url;
    } catch (e) {
      rethrow;
    }
  }



  Future<void> addOutfit(OutfitModel outfit) async {
    try {
      final docRef = _outfitCollection.doc();
      outfit.id = docRef.id;
      await docRef.set(outfit.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OutfitModel>> getOutfits() {
    return _outfitCollection.snapshots().map((event) {
      List<OutfitModel> outfits = [];
      for (var doc in event.docs) {
        final map = doc.data() as Map<String, dynamic>;
        final imageLinks = map['imageLinks'] as List;
        final List<String> imageLinksString = [];
        for (var i = 0; i < imageLinks.length; i++) {
          imageLinksString.add(imageLinks[i].toString());
        }
        outfits.add(
          OutfitModel(
            id: map['id'],
            imageLinks: imageLinksString,
            title: map['title'],
            purchaseUrl: map['purchaseUrl'],
            description: map['description'],
          ),
        );
      }
      return outfits;
    });
  }

  // Stream<OutfitModel> getOutFitsSnapshot() {
  //    _outfitCollection.snapshots().map((event) {
  //     return event.docs.map((e) => OutfitModel.fromMap(e.data() as Map<String, dynamic>));
  //   });
  // }

  Stream<List<OutfitModel>> searchOutfits(String title) {
    return _outfitCollection
        .where(
      'title',
      isGreaterThanOrEqualTo: title,
      isLessThanOrEqualTo: '${title}z',
    )
        .snapshots()
        .map((event) {
      List<OutfitModel> outfits = [];
      for (var doc in event.docs) {
        final map = doc.data() as Map<String, dynamic>;

        // parsing imageLinks as string
        final imageLinks = map['imageLinks'] as List;
        final List<String> imageLinksString = [];
        for (var i = 0; i < imageLinks.length; i++) {
          imageLinksString.add(imageLinks[i].toString());
        }

        outfits.add(
          OutfitModel(
            imageLinks: imageLinksString,
            title: map['title'],
            purchaseUrl: map['purchaseUrl'],
            description: map['description'],
          ),
        );
      }
      return outfits;
    });
  }

  Future<void> editOutfit(OutfitModel outfit) async {
    try {
      _outfitCollection.doc(outfit.id).set(outfit.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
