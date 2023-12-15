import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/notificatin_model.dart';
import '../repository/notification_repository.dart';

final notificationControllerProvider = StateNotifierProvider((ref) {
  return NotificationController(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    ref: ref,
  );
});

final getNotificationProvider = StreamProvider((ref) {
  final notifController = ref.watch(notificationControllerProvider.notifier);
  return notifController.getNotifications();
});

class NotificationController extends StateNotifier<bool> {
  final NotificationRepository _notificationRepository;
  final Ref _ref;
  NotificationController({
    required NotificationRepository notificationRepository,
    required Ref ref,
  })  : _notificationRepository = notificationRepository,
        _ref = ref,
        super(false);

  Stream<List<NotificationModel>> getNotifications() {
    return _notificationRepository.getNotifications();
  }
}
