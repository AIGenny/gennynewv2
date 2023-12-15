
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../components/components.dart';
import '../components/components.dart';
import '../controllers.dart/notification_controller.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends ConsumerState<NotificationScreen> {
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(getNotificationProvider);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadingText(heading: 'Alerts'),
            notifications.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
              data: (notifs) {
                if (notifs.isEmpty) {
                  return const NoResultsWidget(
                    text: "No new alerts for now. Check back later for updates.",
                    imagePath: AssetImages.noAlerts,
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: notifs.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(notification: notifs[index]);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({
    required this.imagePath,
    required this.text,
    super.key,
  });

  final String imagePath, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Image.asset(imagePath),
        HeadingText(heading: text)
      ],
    );
  }
}
