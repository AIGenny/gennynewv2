
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/notificatin_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(notification.time);
    final String displayDate = DateFormat("dd/MM/yy").format(dateTime);
    final String displayTime = DateFormat().add_jm().format(dateTime);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(notification.imageUrl),
          ),
          title: Row(
            children: [
              Text(
                '${notification.name} ',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "$displayDate at $displayTime",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
          subtitle: Text(
            notification.activity,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        if (notification.systemUrl != null && notification.sytemMessage != null)
          Container(
            width: 396,
            height: 37,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => launchUrl(Uri.parse(notification.systemUrl!)),
                  child: Text(
                    notification.sytemMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const Divider()
      ],
    );
  }
}
