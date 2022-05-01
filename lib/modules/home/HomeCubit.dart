import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialkom/models/CreateUser.dart';
import 'package:socialkom/models/MessageModel.dart';
import 'package:socialkom/models/NotificationModel.dart';
import 'package:socialkom/models/PostMode.dart';
import 'package:socialkom/models/SavedPostModel.dart';
import 'package:socialkom/modules/feeds/feeds.dart';
import 'package:socialkom/modules/home/mainHome.dart';
import 'package:socialkom/modules/post/post.dart';
import 'package:socialkom/modules/profile/EditProfile.dart';
import 'package:socialkom/modules/save/savePosts.dart';
import 'package:socialkom/modules/search/search.dart';
import 'package:socialkom/shared/components/constants.dart';
import 'package:socialkom/shared/network/cache_helper.dart';
import 'package:socialkom/shared/styles/color.dart';
import 'package:translator/translator.dart';

import '../../models/StoryMode.dart';
import '../../models/drawerModel.dart';
import '../../modules/home/HomeStates.dart';
import '../chats/chats.dart';
import '../drawer/drawerItems.dart';
import '../notifacations/Notification.dart';
import '../profile/profile.dart';
import '../story/CreateStory.dart';
import '../story/story.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());
  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());

      model = UserModel.fromJson(value.data());

      emit(GetUserSuccessState());
    }).catchError((error) {
      print("${error.toString()} in Home Cubit");
      emit(GetUserErrorState(error));
    });
  }

  int current = 0;
  List<BottomNavigationBarItem> BottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
        size: 26,
      ),
      activeIcon: Icon(
        Icons.home,
        size: 28,
      ),
      label: 'home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.chat_outlined,
        size: 26,
      ),
      activeIcon: Icon(
        Icons.chat,
        size: 28,
      ),
      label: 'chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add_photo_alternate_outlined,
        size: 28,
        color: social4,
      ),
      activeIcon: Icon(
        Icons.add_circle,
        size: 36,
        color: social4,
      ),
      label: 'add post',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.location_on_outlined,
        size: 26,
      ),
      activeIcon: Icon(
        Icons.location_on,
        size: 28,
      ),
      label: 'users',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person_outline,
        size: 26,
      ),
      activeIcon: Icon(
        Icons.person,
        size: 28,
      ),
      label: 'profile',
    ),
  ];

  List<Widget> Screens = [
    Feeds(),
    Chats(),
    NotificationScreen(),
    Story(),
    Profile()
  ];

  List<Widget> Titles = [
    Text(
      "Socialkom",
      style: TextStyle(fontSize: 30),
    ),
    Text(
      "Chats",
      style: TextStyle(fontSize: 26),
    ),
    Text(
      "Notifications",
      style: TextStyle(fontSize: 26),
    ),
    Text(
      "Story",
      style: TextStyle(fontSize: 26),
    ),
    Text(
      "Profile",
      style: TextStyle(fontSize: 26),
    )
  ];

  void changeIndex(int index, context) {
    if (index == 1) getChatUsers();
    if (index == 3) getPersonalStory2();
    if (index == 4) getPersonalPost2();
    if (index == 2) {
      getNotifications();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
    }
    current = index;
    emit(ChangeBottomNavState());
  }

  File? ProfileImage;
  var _picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(ProfileImagePickedErrorState());
    }
  }

  File? CoverImage;

  Future getCoverImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(CoverImagePickedErrorState());
    }
  }

  // here upload to storage
  void uploadProfile(
      {required String email,
      required String name,
      required String phone,
      required String bio,
      required bool theme}) {
    emit(UpdateLoadingState());
    // here upload to storage
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      // here upload to database
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            email: email,
            name: name,
            phone: phone,
            bio: bio,
            image: value,
            theme: theme);
        // emit(UploadProfileImagePickedSuccessState());
        // print(value);
      }).catchError((error) {
        emit(UploadProfileImagePickedErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(UploadProfileImagePickedErrorState());
      print(error.toString());
    });
  }

  void uploadCover(
      {required String email,
      required String name,
      required String phone,
      required String bio,
      required bool theme}) {
    emit(UpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            email: email,
            name: name,
            phone: phone,
            bio: bio,
            cover: value,
            theme: theme);
        // emit(UploadCoverImagePickedSuccessState());
        // print(value);
      }).catchError((error) {
        emit(UploadCoverImagePickedErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(UploadCoverImagePickedErrorState());
      print(error.toString());
    });
  }

  void uploadProfileAndCover(
      {required String email,
      required String name,
      required String phone,
      required String bio,
      required bool theme}) {
    emit(UpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            email: email,
            name: name,
            phone: phone,
            bio: bio,
            image: value,
            theme: theme);
      }).catchError((error) {
        emit(UploadProfileImagePickedErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(UploadProfileImagePickedErrorState());
      print(error.toString());
    });
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            email: email,
            name: name,
            phone: phone,
            bio: bio,
            cover: value,
            theme: theme);
        // emit(UploadCoverImagePickedSuccessState());
        // print(value);
      }).catchError((error) {
        emit(UploadCoverImagePickedErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(UploadCoverImagePickedErrorState());
      print(error.toString());
    });
  }

  // here upload to database
  void updateUserData({
    required String email,
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
    bool? theme,
  }) {
    emit(UpdateLoadingState());
    UserModel createUserModel = UserModel(
        uId: model!.uId,
        EmailVerified: false,
        name: name,
        email: email,
        phone: phone,
        image: image ?? model!.image,
        background: cover ?? model!.background,
        bio: bio,
        theme: theme ?? model!.theme);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(createUserModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateErrorState());
    });
  }

  File? PostImage;

  Future getPostImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(CreatePostImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(CreatePostImagePickedErrorState());
    }
  }

  Future getPostFeedsImage(context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(CreatePostImagePickedSuccessState());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
    } else {
      print("No image selected");
      emit(CreatePostImagePickedErrorState());
    }
  }

  void removePostImage() {
    PostImage = null;
    emit(RemovePostImagePickedSuccessState());
  }

  void uploadPostImage({
    required DateTime date,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(date: date, text: text, postImage: value);
        // print(value);
      }).catchError((error) {
        emit(CreatePostSuccessState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
      print(error.toString());
    });
  }

  void createPost({
    required DateTime date,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel createUserModel = PostModel(
      uId: model!.uId,
      date: date,
      name: model!.name,
      text: text,
      postImage: postImage ?? "",
      image: model!.image,
      likes: {},
      likesNum: [],
      myLike: false,
      comments: [],
      commentsNum: [],
      commentsImage: [],
      commentsName: [],
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(createUserModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  // story
  File? StoryImage;

  Future getStoryImage(context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      StoryImage = File(pickedFile.path);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateStory()));
      emit(CreateStoryImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(CreateStoryImagePickedErrorState());
    }
  }

  void createStoryImage({
    required DateTime date,
    String? text,
  }) {
    emit(CreateStoryLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('stories/${Uri.file(StoryImage!.path).pathSegments.last}')
        .putFile(StoryImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadStory(date: date, text: text, storyImage: value);
        emit(CreateStorySuccessState());
        print(value);
      }).catchError((error) {
        emit(CreateStoryErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(CreateStoryErrorState());
      print(error.toString());
    });
  }

  void uploadStory({
    required DateTime date,
    String? text,
    required String storyImage,
  }) {
    StoryModel storyModel = StoryModel(
      uId: model!.uId,
      date: date,
      name: model!.name,
      text: text ?? "",
      storyImage: storyImage,
      image: model!.image,
    );

    FirebaseFirestore.instance
        .collection('stories')
        .add(storyModel.toMap())
        .then((value) {
      emit(CreateStorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateStoryErrorState());
    });
  }

  void removeStoryImage() {
    StoryImage = null;
    emit(RemoveStoryImagePickedSuccessState());
  }

  bool addText = false;
  void AddText() {
    addText = !addText;
    emit(AddTextSuccessState());
  }

  void closeStory() {
    emit(CloseCreateStoryScreenState());
  }

  // get post
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<bool> isLike = [];
  List<bool> isTranslated = [];
  int likesNum = 0;
  void getPost() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      posts = [];
      postsId = [];
      likes = [];
      isLike = [];
      isTranslated = [];
      event.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          isTranslated.add(false);
          posts.add(PostModel.fromJson(element.data()));
          emit(GetPostSuccessState());
        }).catchError((error) {
          print(error.toString());
        });
      });

      emit(GetPostSuccessState());
    });
  }

  PostModel? postNotificationModel;
  void getNotificationPost(String postId) {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) {
      postNotificationModel = PostModel.fromJson(value.data());
      emit(GetPostSuccessState());
    }).catchError((error) {
      print("${error.toString()} from getNotificationPost");
      emit(GetPostErrorState(error));
    });
  }

  List<PostModel> postsPersonal = [];
  List<String> postsIdPersonal = [];
  List<int> likesPersonal = [];
  List<bool> isTranslatedPersonal = [];

  void getPersonalPost2() {
    emit(GetPostPersonalLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      postsPersonal = [];
      postsIdPersonal = [];
      likesPersonal = [];
      isTranslatedPersonal = [];
      event.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          if (element.data()['uId'] == model!.uId) {
            likesPersonal.add(value.docs.length);

            postsIdPersonal.add(element.id);
            isTranslatedPersonal.add(false);
            postsPersonal.add(PostModel.fromJson(element.data()));
          }

          emit(GetPostPersonalSuccessState());
        }).catchError((error) {
          print("${error.toString()} from Personal posts");
          emit(GetPostPersonalErrorState(error));
        });
      });

      emit(GetPostPersonalSuccessState());
    });
  }

  // get story
  // List<StoryModel> personalStories = [];
  // void getPersonalStory() {
  //   emit(GetStoryPersonalLoadingState());
  //   FirebaseFirestore.instance.collection('stories').get().then((value) {
  //     value.docs.forEach((element) {
  //       if (element.data()['uId'] == model!.uId)
  //         personalStories.add(StoryModel.fromJson(element.data()));
  //     });
  //     emit(GetStoryPersonalSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetStoryPersonalErrorState(error.toString()));
  //   });
  // }
  List<StoryModel> Stories = [];
  void getStories() {
    emit(GetStoryLoadingState());
    FirebaseFirestore.instance
        .collection('stories')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      Stories = [];
      event.docs.forEach((element) {
        Stories.add(StoryModel.fromJson(element.data()));
      });
    });
    emit(GetStorySuccessState());
  }

  // void getStories() {
  //   emit(GetStoryLoadingState());
  //   FirebaseFirestore.instance.collection('stories').get().then((value) {
  //     value.docs.forEach((element) {
  //       Stories.add(StoryModel.fromJson(element.data()));
  //     });
  //     emit(GetStorySuccessState());
  //   }).catchError((error) {
  //     print("${error.toString()} from stories");
  //     emit(GetStoryErrorState(error));
  //   });
  // }

  List<StoryModel> personalStories2 = [];
  void getPersonalStory2() {
    emit(CreateStoryLoadingState());
    personalStories2 = [];
    Stories.forEach((element) {
      if (element.uId == model!.uId) personalStories2.add(element);
    });
    emit(GetStorySuccessState());
  }

  void likePost(String postId, {bool like = true}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': like}).then((value) {
      emit(LikesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LikesErrorState(error));
    });
  }

  PostModel? postModel;
  NotificationModel? notificationModel;
  void likePost2(String postId, DateTime date) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) {
      postModel = PostModel.fromJson(value.data());
    }).then((value) {
      if (postModel!.likes[model!.uId] == false ||
          postModel!.likes[model!.uId] == null) {
        postModel!.likes[model!.uId] = true;
        //notifications
        if (postModel!.uId != model!.uId) {
          notificationModel = NotificationModel(
              userName: model!.name,
              userImage: model!.image,
              userUid: model!.uId,
              date: date,
              event: "liked your post",
              postId: postId,
              postImage: postModel!.postImage,
              notificationType: 'like');
          FirebaseFirestore.instance
              .collection('users')
              .doc(postModel!.uId)
              .collection('notification')
              .add(notificationModel!.toMap())
              .then((value) {});
        }
      } else {
        postModel!.likes[model!.uId] = false;
      }
      postModel!.likesNum = [];
      postModel!.likes.forEach((key, value) {
        if (value == true) {
          postModel!.likesNum!.add(key);
          //  notification

        } else {
          postModel!.likesNum!.remove(key);
        }
      });

      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update(postModel!.toMap())
          .then((value) {
        emit(LikesSuccessState());
      });
    }).catchError((error) {
      emit(LikesErrorState(error));
    });
  }

  void CreateCommentPost(String postId, String commentText, DateTime date) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) {
      postModel = PostModel.fromJson(value.data());
    }).then((value) {
      postModel!.comments.add(commentText);
      postModel!.commentsName.add(model!.name);
      postModel!.commentsImage.add(model!.image);
      //  notification
      if (postModel!.uId != model!.uId) {
        notificationModel = NotificationModel(
            userName: model!.name,
            userImage: model!.image,
            userUid: model!.uId,
            date: date,
            event: "commented in your post",
            postId: postId,
            postImage: postModel!.postImage,
            notificationType: 'comment');
        FirebaseFirestore.instance
            .collection('users')
            .doc(postModel!.uId)
            .collection('notification')
            .add(notificationModel!.toMap())
            .then((value) {});
      }
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update(postModel!.toMap())
          .then((value) {
        emit(CreateCommentSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(CreateCommentErrorState(error));
    });
  }

  List Comments = [];
  List CommentsUserName = [];
  List CommentsUserImages = [];
  void getCommentPost(String postId) {
    emit(GetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) {
      postModel = PostModel.fromJson(value.data());
    }).then((value) {
      Comments = [];
      CommentsUserName = [];
      CommentsUserImages = [];
      Comments = postModel!.comments;
      CommentsUserName = postModel!.commentsName;
      CommentsUserImages = postModel!.commentsImage;
      print(Comments.toString());
      emit(GetCommentsSuccessState());
    }).catchError((error) {
      print("${error.toString()} from get comment");
      emit(GetCommentsErrorState(error));
    });
  }

  List<NotificationModel> notifications = [];
  void getNotifications() {
    emit(GetNotificationsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('notification')
        .orderBy('date')
        .get()
        .then((value) {
      notifications = [];
      value.docs.forEach((element) {
        notifications.add(NotificationModel.fromJson(element.data()));
      });
      emit(GetNotificationsSuccessState());
    }).catchError((error) {
      print("${error.toString()} from get notification");
      emit(GetNotificationsErrorState(error));
    });
  }

  List<UserModel> users = [];
  void getChatUsers() {
    emit(GetAllChatUserLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(GetAllChatUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllChatUserErrorState(error));
      });
  }

  List<UserModel> usersSearch = [];
  void getSearchUsers(String name) {
    emit(GetAllSearchUserLoadingState());
    usersSearch = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] == name)
          usersSearch.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllSearchUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllSearchUserErrorState(error));
    });
  }

  UserModel? friendModel;
  List<PostModel> postsFriends = [];
  List<String> postsIdFriends = [];
  List<int> likesFriends = [];
  List<bool> isTranslatedFriends = [];
  void getFriendData(String userId) {
    emit(GetUserFriendLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      friendModel = UserModel.fromJson(value.data());
      postsFriends = [];
      postsIdFriends = [];
      likesFriends = [];
      isTranslatedFriends = [];
      if (postsFriends.length == 0) {
        getFriendPosts();
      }

      emit(GetUserFriendSuccessState());
    }).catchError((error) {
      print("${error.toString()} in Home Cubit");
      emit(GetUserFriendErrorState(error));
    });
  }

  void getFriendPosts() {
    emit(GetPostFriendsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        postsFriends = [];
        postsIdFriends = [];
        likesFriends = [];
        isTranslatedFriends = [];
        element.reference.collection('likes').get().then((value) {
          if (element.data()['uId'] == friendModel!.uId) {
            likesFriends.add(value.docs.length);
            isTranslatedFriends.add(false);
            postsIdFriends.add(element.id);

            postsFriends.add(PostModel.fromJson(element.data()));
          }

          emit(GetPostFriendsSuccessState());
        }).catchError((error) {
          print("${error.toString()} from Friends posts");
          emit(GetPostFriendsErrorState(error));
        });
      });

      emit(GetPostFriendsSuccessState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: model!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);
    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendingMessageSuccessState());
    }).catchError((error) {
      emit(SendingMessageErrorState());
    });
    //set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendingMessageSuccessState());
    }).catchError((error) {
      emit(SendingMessageErrorState());
    });
  }

  List<MessageModel> messages = [
    MessageModel(
        senderId: '',
        receiverId: '',
        dateTime: '',
        text: "Chat  with your friend")
  ];
  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [
        MessageModel(
            senderId: '',
            receiverId: '',
            dateTime: '',
            text: "Chat  with your friend")
      ];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(GetMessageSuccessState());
    });
  }

  void getMessageWithoutStreaming({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .get()
        .then((event) {
      messages = [
        MessageModel(
            senderId: '',
            receiverId: '',
            dateTime: '',
            text: "Chat  with your friend")
      ];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(GetMessageSuccessState());
    });
  }

  bool isFirst = true;
  void doThis() {
    isFirst = !isFirst;
  }

  bool isMessage = false;
  bool isMessage2 = true;

  void changeMessageButton() {
    isMessage = true;
    if (isMessage2) {
      emit(ChangeMessageMicButtonState());
      isMessage2 = false;
    }
  }

  bool isComment = false;
  void showCommentButton() {
    isComment = true;
    emit(ShowCommentButtonState());
  }

  void hideCommentButton() {
    isComment = false;
    emit(HideCommentButtonState());
  }

  MenuItem currentItem = MenuItems.home;
  void changeItem(MenuItem item, context) {
    currentItem = item;
    getScreen(context);
    emit(ChangeMenuItemState());
  }

  Widget MenuScreen = MainHome();
  void getScreen(context) {
    if (currentItem == MenuItems.home) {
      changeIndex(0, context);
      MenuScreen = MainHome();
    } else if (currentItem == MenuItems.notification) {
      changeIndex(2, context);
      MenuScreen = MainHome();
    } else if (currentItem == MenuItems.profile) {
      changeIndex(4, context);
      MenuScreen = MainHome();
    } else if (currentItem == MenuItems.chats) {
      changeIndex(1, context);
      MenuScreen = MainHome();
    } else if (currentItem == MenuItems.stories) {
      changeIndex(3, context);
      MenuScreen = MainHome();
    } else if (currentItem == MenuItems.explore) {
      MenuScreen = Search();
    } else if (currentItem == MenuItems.settings) {
      MenuScreen = EditProfile();
    } else if (currentItem == MenuItems.save) {
      MenuScreen = SavedPosts();
    } else {
      MenuScreen = MainHome();
    }
    emit(ChangeMenuScreenState());
  }

  String translate = '';
  void translateTest(String text) {
    translate = text;
    emit(TranslateTextState());
  }

  String translateEditPost = '';
  void translateEditPostTest(String text) {
    text.translate(from: 'en', to: 'ar').then((value) {
      translateEditPost = value.text;
    });
    emit(TranslateTextState());
  }

  bool isTranslate = false;
  void showTranslate() {
    isTranslate = !isTranslate;
    emit(ShowTranslateTextState());
  }

  String transPost = '';
  void translatePost(String text, int index, bool isPersonal) {
    text.translate(from: 'en', to: 'ar').then((value) {
      transPost = value.text;
      if (isPersonal) {
        isTranslatedPersonal = List.filled(isTranslatedPersonal.length, false);
        isTranslatedPersonal[index] = true;
      } else {
        isTranslated = List.filled(isTranslated.length, false);
        isTranslated[index] = true;
      }
      emit(TranslateTextState());
    }).catchError((error) {
      print(error.toString());
      emit(TranslateTextErrorState());
    });
  }

  String transFriendPost = '';
  void translateFriendPost(
    String text,
    int index,
  ) {
    text.translate(from: 'en', to: 'ar').then((value) {
      transFriendPost = value.text;
      isTranslatedFriends = List.filled(isTranslatedFriends.length, false);
      isTranslatedFriends[index] = true;
      emit(TranslateTextState());
    }).catchError((error) {
      print(error.toString());
      emit(TranslateTextErrorState());
    });
  }

  String transNotificationPost = '';
  void translateNotificationPost(
    String text,
  ) {
    text.translate(from: 'en', to: 'ar').then((value) {
      transNotificationPost = value.text;
      emit(TranslateTextState());
    }).catchError((error) {
      print(error.toString());
      emit(TranslateTextErrorState());
    });
  }

  SavedPostModel? savedPostModel;
  void savePost(
      {required String postId,
      required DateTime date,
      required String userName,
      required String userId,
      required String userImage,
      String? postImage,
      String? postText}) {
    savedPostModel = SavedPostModel(
        postId: postId,
        date: date,
        userName: userName,
        userId: userId,
        userImage: userImage,
        postImage: postImage ?? '',
        postText: postText ?? '');
    notificationModel = NotificationModel(
        userName: model!.name,
        userImage: model!.image,
        date: date,
        event: 'Saved your post',
        postId: postId,
        notificationType: 'save',
        postImage: postImage ?? '',
        userUid: model!.uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('savedPosts')
        .add(savedPostModel!.toMap())
        .then((value) {
      if (userId != model!.uId)
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('notification')
            .add(notificationModel!.toMap())
            .then((value) {})
            .catchError((error) {
          print("${error.toString()} from savePostNotification");
        });
      emit(SavePostSuccessState());
    }).catchError((error) {
      print("${error.toString()} from savePost");
      emit(SavePostErrorState());
    });
  }

  List<SavedPostModel> savedPosts = [];
  List<SavedPostModel> savedPostsWithImagesWithText = [];
  List<SavedPostModel> savedPostsWithImages = [];
  List<SavedPostModel> savedPostsWithText = [];
  void getSavedPosts() {
    emit(GetSavedPostLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('savedPosts')
        .orderBy('date')
        .get()
        .then((value) {
      savedPosts = [];
      savedPostsWithImagesWithText = [];
      savedPostsWithImages = [];
      savedPostsWithText = [];
      value.docs.forEach((element) {
        savedPosts.add(SavedPostModel.fromJson(element.data()));
        if (element.data()['postImage'] != '' &&
            element.data()['postText'] != '')
          savedPostsWithImagesWithText
              .add(SavedPostModel.fromJson(element.data()));
        if (element.data()['postImage'] != '' &&
            element.data()['postText'] == '')
          savedPostsWithImages.add(SavedPostModel.fromJson(element.data()));
        if (element.data()['postImage'] == '' &&
            element.data()['postText'] != '')
          savedPostsWithText.add(SavedPostModel.fromJson(element.data()));
      });
      emit(GetSavedPostSuccessState());
    }).catchError((error) {
      print("${error.toString()} from getSavedPosts");
      emit(GetSavedPostErrorState());
    });
  }

  void saveToGallery(String imageUrl) {
    emit(SavedToGalleryLoadingState());
    GallerySaver.saveImage(imageUrl, albumName: 'SocialKom').then((value) {
      emit(SavedToGallerySuccessState());
    }).catchError((error) {
      print("${error.toString()} from saveToGallery");
      emit(SavedToGalleryErrorState());
    });
  }

  void editPost(
      {required PostModel postModel,
      required String postId,
      required String text,
      String? postImage}) {
    emit(EditPostLoadingState());
    postModel = PostModel(
        uId: postModel.uId,
        name: postModel.name,
        image: postModel.image,
        date: postModel.date,
        likes: postModel.likes,
        myLike: postModel.myLike,
        likesNum: postModel.likesNum,
        comments: postModel.comments,
        commentsNum: postModel.commentsNum,
        commentsName: postModel.commentsName,
        commentsImage: postModel.commentsImage,
        text: text,
        postImage: postImage ?? postModel.postImage);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(postModel.toMap())
        .then((value) {
      emit(EditPostSuccessState());
    }).catchError((error) {
      print("${error.toString()} from urlUpdatePost");
      emit(EditPostErrorState());
    });
  }

  void editPostWithImage(
      {required PostModel postModel,
      required String postId,
      required String text,
      String? postImage}) {
    emit(EditPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('editedPosts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        editPost(
            postModel: postModel, postId: postId, text: text, postImage: value);
      }).catchError((error) {
        print("${error.toString()} from urlUpdatePost");
        emit(EditPostErrorState());
      });
    }).catchError((error) {
      print("${error.toString()} from urlUpdatePost");
      emit(EditPostErrorState());
    });
  }

  bool isLight = CacheHelper.getData(key: 'isLight') ?? true;
  void changeThemeApp({bool? fromShared}) {
    if (fromShared != null) {
      isLight = fromShared;
      emit(ChangeThemeState());
    } else {
      isLight = !isLight;
      CacheHelper.saveData(key: 'isLight', value: isLight).then((value) {
        model!.theme = isLight;
        emit(ChangeThemeState());
      });
    }
  }

  void changeSwitchTheme() {
    model!.theme = !model!.theme;
    emit(ChangeSwitchThemeState());
  }
}
