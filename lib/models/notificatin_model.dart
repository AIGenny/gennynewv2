import 'dart:convert';

class NotificationModel {
  final String toUid, fromUid, activity, name, imageUrl;
  final String? systemUrl, sytemMessage;
  final int time;

  NotificationModel({
    required this.name,
    required this.imageUrl,
    required this.activity,
    required this.toUid,
    required this.fromUid,
    required this.time,
    this.systemUrl,
    this.sytemMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'toUid': toUid,
      'fromUid': fromUid,
      'activity': activity,
      'time': time,
      'name': name,
      'imageUrl': imageUrl,
      'systemUrl': systemUrl,
      'systemMessage': sytemMessage
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      activity: map['activity'],
      toUid: map['toUid'],
      fromUid: map['fromUid'],
      time: map['time'],
      imageUrl: map['imageUrl'],
      name: map['name'],
      systemUrl: map['systemUrl'],
      sytemMessage: map['systemMessage'],
    );
  }

  @override
  String toString() {
    return 'NotificationModel(toUid: $toUid, fromUid: $fromUid, activity: $activity, time: ${DateTime.fromMillisecondsSinceEpoch(time)})';
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
