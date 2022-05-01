import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  late DateTime date;
  late String userImage;
  late String userName;
  String? userUid;
  late String event;
  String? postImage;
  late String postId;
  late String notificationType;

  NotificationModel({
    required this.userName,
    required this.userImage,
    this.userUid,
    this.postImage,
    required this.date,
    required this.event,
    required this.postId,
    required this.notificationType,
  });

  NotificationModel.fromJson(Map<String, dynamic>? json) {
    date = (json!['date'] as Timestamp).toDate();
    userImage = json['userImage'];
    userName = json['userName'];
    userUid = json['userUid'];
    event = json['event'];
    postImage = json['postImage'];
    postId = json['postId'];
    notificationType = json['notificationType'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'userName': userName,
      'userImage': userImage,
      'userUid': userUid,
      'event': event,
      'postImage': postImage,
      'postId': postId,
      'notificationType': notificationType,
    };
  }
}
