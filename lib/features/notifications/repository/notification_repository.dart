
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../models/notificatin_model.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(
    firestore: ref.read(firestoreProvider),
    uid: ref.read(authProvider).currentUser!.uid,
  );
});

class NotificationRepository {
  final FirebaseFirestore _firestore;
  final String _uid;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  DocumentReference get _userDoc => _users.doc(_uid);

  CollectionReference get _notificationCollection =>
      _userDoc.collection(FirebaseConstants.notificationCollection);

  NotificationRepository({
    required FirebaseFirestore firestore,
    required String uid,
  })  : _firestore = firestore,
        _uid = uid;

  Stream<List<NotificationModel>> getNotifications() {
    return _notificationCollection.orderBy("time", descending: true).snapshots().map((event) {
      List<NotificationModel> notifs = [];
      for (var doc in event.docs) {
        notifs.add(
          NotificationModel.fromMap(doc.data() as Map<String, dynamic>),
        );
      }
      return notifs;
    });
  }
}
