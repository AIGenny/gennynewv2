import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';

final settingRepositoryProvider = Provider<SettingRepository>((ref) {
  return SettingRepository(
    firestore: ref.read(firestoreProvider),
    uid: ref.read(authProvider).currentUser!.uid,
  );
});

class SettingRepository {
  final FirebaseFirestore _firestore;
  final String _uid;

  SettingRepository({required FirebaseFirestore firestore, required String uid})
      : _firestore = firestore,
        _uid = uid,
        super();

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
  DocumentReference get _userDoc => _users.doc(_uid);

  void setUserChoices(String option, bool value) {
    _userDoc.update({option: value});
  }

  

}
