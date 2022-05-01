import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String name;
  late String uId;

  late String image;
  String? postImage;
  late DateTime date;
  String? text;
  late Map<String, dynamic> likes;
  List? likesNum;
  late List<dynamic> comments = [];
  late List<dynamic> commentsName = [];
  late List<dynamic> commentsImage = [];
  List? commentsNum;
  late bool myLike;

  PostModel({
    required this.uId,
    required this.name,
    required this.image,
    this.text,
    required this.date,
    this.postImage,
    required this.likes,
    required this.myLike,
    required this.likesNum,
    required this.comments,
    required this.commentsNum,
    required this.commentsName,
    required this.commentsImage,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];

    uId = json['uId'];

    image = json['image'];
    postImage = json['postImage'];
    date = (json['date'] as Timestamp).toDate();
    text = json['text'];
    likes = json['likes'];
    myLike = json['myLike'];
    likesNum = json['likesNum'];
    comments = json['comments'];
    commentsNum = json['commentsNum'];
    commentsName = json['commentsName'];
    commentsImage = json['commentsImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'postImage': postImage,
      'date': date,
      'likes': likes,
      'myLike': myLike,
      'likesNum': likesNum,
      'comments': comments,
      'commentsNum': commentsNum,
      'commentsName': commentsName,
      'commentsImage': commentsImage,
    };
  }
}

class CommentsModel {
  late String name;
  late String uId;
  late String image;
  String? commentImage;
  late String date;
  String? text;

  CommentsModel({
    required this.uId,
    required this.name,
    required this.image,
    this.text,
    this.commentImage,
    required this.date,
  });
  CommentsModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];

    uId = json['uId'];

    image = json['image'];
    commentImage = json['commentImage'];
    date = json['date'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'commentImage': commentImage,
      'date': date,
    };
  }
}
