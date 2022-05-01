import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  late String name;
  late String uId;
  late String image;
  late String storyImage;
  late DateTime date;
  String? text;

  StoryModel(
      {required this.uId,
      required this.name,
      required this.image,
      this.text,
      required this.date,
      required this.storyImage});

  StoryModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    storyImage = json['storyImage'];
    date = (json['date'] as Timestamp).toDate();
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'storyImage': storyImage,
      'date': date
    };
  }
}
