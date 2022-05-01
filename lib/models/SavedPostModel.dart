import 'package:cloud_firestore/cloud_firestore.dart';

class SavedPostModel {
  late DateTime date;
  late String userImage;
  late String userName;
  late String userId;
  String? postImage;
  late String postId;
  String? postText;

  SavedPostModel(
      {required this.postId,
      required this.date,
      required this.userName,
      required this.userId,
      required this.userImage,
      this.postImage,
      this.postText});
  SavedPostModel.fromJson(Map<String, dynamic>? json) {
    userName = json!['userName'];
    userImage = json['userImage'];
    userId = json['userId'];
    postImage = json['postImage'];
    postText = json['postText'];
    postId = json['postId'];
    date = (json['date'] as Timestamp).toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userImage': userImage,
      'userId': userId,
      'postImage': postImage,
      'postText': postText,
      'postId': postId,
      'date': date,
    };
  }
}
