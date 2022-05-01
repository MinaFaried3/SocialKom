class UserModel {
  late String name;
  late String phone;
  late String email;
  late String uId;
  late String image;
  late String background;
  late String bio;
  late bool theme;
  late int post;

  bool? EmailVerified;

  UserModel(
      {required this.uId,
      required this.name,
      required this.email,
      required this.phone,
      this.EmailVerified = false,
      this.post = 0,
      required this.image,
      required this.background,
      required this.theme,
      required this.bio});

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    EmailVerified = json['EmailVerified'];
    image = json['image'];
    background = json['background'];
    bio = json['bio'];
    post = json['post'];
    theme = json['theme'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'phone': phone,
      'EmailVerified': EmailVerified,
      'image': image,
      'background': background,
      'bio': bio,
      'post': post,
      'theme': theme,
    };
  }
}
