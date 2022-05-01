class MessageModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String text;


  MessageModel({required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    senderId = json!['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'dateTime': dateTime,

    };
  }
}