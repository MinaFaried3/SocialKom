import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:socialkom/models/CreateUser.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/modules/profile/showImage.dart';

import '../../models/PostMode.dart';
import '../../shared/styles/color.dart';
import '../Chat_Screens/ChatScreen.dart';
import 'CommentOnFriendSProfile.dart';

class FriendProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = HomeCubit.get(context);
        UserModel? model = bloc.friendModel;
        return Scaffold(
          appBar: AppBar(
            title: model != null && state is! GetUserFriendLoadingState
                ? Text("${model.name}")
                : Center(
                    child: CircularProgressIndicator(
                    color: social3,
                  )),
            leading: IconButton(
              onPressed: () {
                model = null;
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: ConditionalBuilderRec(
            condition: model != null && state is! GetUserFriendLoadingState,
            fallback: (context) => Center(
                child: CircularProgressIndicator(
              color: social3,
            )),
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Column(
                  children: [
                    Container(
                      height: 220,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowImage(
                                            image: model!.background)));
                              },
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage(model!.background),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowImage(image: model!.image)));
                            },
                            child: CircleAvatar(
                              radius: 63,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(model!.image),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // width: MediaQuery.of(context).size.width / 2.2,
                          child: Text(
                            model!.name,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: social3,
                          size: 25,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        model!.bio,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 15),
                        textAlign: TextAlign.center,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "5",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    "Posts",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "10K",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    "Followers",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "87",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    "Following",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "1556",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    "Photos",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              child: MaterialButton(
                                  onPressed: () {
                                    FirebaseMessaging.instance
                                        .subscribeToTopic('announcements');
                                  },
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(
                                        color: social3,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              child: MaterialButton(
                                  onPressed: () {
                                    // FirebaseMessaging.instance
                                    //     .unsubscribeFromTopic('announcements');

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatScreen(model!)));
                                  },
                                  child: Text(
                                    "Message",
                                    style: TextStyle(
                                        color: social3,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(
                              context,
                              bloc.postsFriends[index],
                              index,
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                        itemCount: bloc.postsFriends.length),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(
    context,
    PostModel model,
    index,
  ) {
    var bloc = HomeCubit.get(context).model;

    var bloc1 = HomeCubit.get(context);
    late int LikesNumber;
    late int CommentsNumber;
    late String postId;
    late bool isTranslated;
    TextEditingController comment = TextEditingController();

    LikesNumber = HomeCubit.get(context).postsFriends[index].likesNum!.length;
    CommentsNumber = HomeCubit.get(context).postsFriends[index].comments.length;
    postId = HomeCubit.get(context).postsIdFriends[index];
    isTranslated = HomeCubit.get(context).isTranslatedFriends[index];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 6,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: model.uId == bloc!.uId
                        ? NetworkImage(bloc.image)
                        : NetworkImage(model.image),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              model.uId == bloc.uId ? bloc.name : model.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: social3,
                              size: 17,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        DateFormat.yMMMd().format(model.date),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                if (model.text != '')
                  IconButton(
                      onPressed: () async {
                        bloc1.translateFriendPost(model.text!, index);
                      },
                      icon: Icon(
                        Icons.translate,
                        color: social3,
                      )),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      bloc1.savePost(
                                          postId: postId,
                                          date: DateTime.now(),
                                          userName: model.name,
                                          userId: model.uId,
                                          userImage: model.image,
                                          postText: model.text,
                                          postImage: model.postImage);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.turned_in_not_sharp,
                                            color: social1,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Save Post",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  if (model.postImage != '')
                                    InkWell(
                                      onTap: () {
                                        bloc1.saveToGallery(model.postImage!);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.save_outlined,
                                              color: social1,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Save Post Image",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.share,
                                            color: social1,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Share",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.grey,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 0.8,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (model.text != '')
              Text(
                model.text!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 15),
              ),
            if (model.text != '')
              SizedBox(
                height: 10,
              ),
            if (model.text != '' && bloc1.transFriendPost != '' && isTranslated)
              Text(bloc1.transFriendPost,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 15, color: Colors.grey)),
            if (model.postImage != '')
              Container(
                // height: 250,
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                      image: NetworkImage(model.postImage!), fit: BoxFit.cover),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.pink,
                          ),

                          // Text("${HomeCubit.get(context).likes[index]}"),
                          SizedBox(
                            width: 5,
                          ),

                          Text(
                            "${LikesNumber}",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),

                          // Text(
                          //     "${HomeCubit.get(context).posts[index].likes[HomeCubit.get(context).model!.uId].toString()}"),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      bloc1.getCommentPost(postId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentsFriendsScreen(
                                    likesNumber: LikesNumber,
                                    index: index,
                                    postId: postId,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$CommentsNumber ",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            "comments",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 13, left: 40, right: 40, top: 5),
              child: Container(
                width: double.infinity,
                height: 0.8,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 17,
                          backgroundImage:
                              NetworkImage(HomeCubit.get(context).model!.image),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: comment,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'write a comment .....',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        fontSize: 15, color: Colors.grey[400])),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            var date = DateTime.now();
                            if (comment.text != '')
                              bloc1.CreateCommentPost(
                                  postId, comment.text, date);
                            bloc1.getCommentPost(postId);
                          },
                          icon: Icon(Icons.send_outlined),
                          color: social3,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    var date = DateTime.now();
                    HomeCubit.get(context).likePost2(
                        HomeCubit.get(context).postsIdFriends[index], date);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        if ((HomeCubit.get(context)
                                    .postsFriends[index]
                                    .likes[HomeCubit.get(context).model!.uId] !=
                                true ||
                            HomeCubit.get(context)
                                    .postsFriends[index]
                                    .likes[HomeCubit.get(context).model!.uId] ==
                                null))
                          Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                        if (HomeCubit.get(context)
                                .postsFriends[index]
                                .likes[HomeCubit.get(context).model!.uId] ==
                            true)
                          Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Like",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
