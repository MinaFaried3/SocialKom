import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:socialkom/modules/post/EditPosts.dart';
import 'package:socialkom/modules/post/comments.dart';
import 'package:socialkom/modules/post/showPost.dart';
import 'package:socialkom/modules/profile/FriendProfile.dart';

import '../../models/PostMode.dart';
import '../../modules/home/HomeCubit.dart';
import '../styles/color.dart';

Widget buildPostItem(context, PostModel model, index,
    {bool? isPersonal = false}) {
  var bloc = HomeCubit.get(context).model;
  var bloc1 = HomeCubit.get(context);
  late int LikesNumber;
  late int CommentsNumber;
  late String postId;
  late bool isTranslated;
  TextEditingController comment = TextEditingController();

  if (isPersonal!) {
    LikesNumber = HomeCubit.get(context).postsPersonal[index].likesNum!.length;
    CommentsNumber =
        HomeCubit.get(context).postsPersonal[index].comments.length;
    postId = HomeCubit.get(context).postsIdPersonal[index];
    isTranslated = HomeCubit.get(context).isTranslatedPersonal[index];
  } else {
    LikesNumber = HomeCubit.get(context).posts[index].likesNum!.length;
    CommentsNumber = HomeCubit.get(context).posts[index].comments.length;
    postId = HomeCubit.get(context).postsId[index];
    isTranslated = HomeCubit.get(context).isTranslated[index];
  }
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
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
                onTap: () {
                  if (model.uId != bloc1.model!.uId) {
                    bloc1.getFriendData(model.uId);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FriendProfile()));
                  } else {
                    bloc1.changeIndex(4, context);
                  }
                },
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
                      onTap: () {
                        if (model.uId != bloc1.model!.uId) {
                          bloc1.getFriendData(model.uId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FriendProfile()));
                        } else {
                          bloc1.changeIndex(4, context);
                        }
                      },
                      child: Row(
                        children: [
                          Text(model.uId == bloc.uId ? bloc.name : model.name,
                              style: Theme.of(context).textTheme.headline6),
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
                      bloc1.translatePost(model.text!, index, isPersonal);
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
                                if (model.uId == bloc1.model!.uId)
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditPosts(
                                                    postModel: model,
                                                    postId: postId,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit_location_outlined,
                                            color: social1,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Edit Post",
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
          if (model.text != '')
            SizedBox(
              height: 10,
            ),
          if (model.text != '')
            Text(
              model.text!,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          SizedBox(
            height: 10,
          ),
          if (model.text != '' && bloc1.transPost != '' && isTranslated)
            Text(
              bloc1.transPost,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 15, color: Colors.grey),
            ),
          SizedBox(
            height: 10,
          ),
          if (model.postImage != '')
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowPost(
                              post: model,
                              postId: postId,
                              index: index,
                              isPersonal: isPersonal,
                            )));
              },
              child: Container(
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
                            builder: (context) => CommentsScreen(
                                  likesNumber: LikesNumber,
                                  isPersonal: isPersonal,
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
                          style: Theme.of(context).textTheme.subtitle2!,
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
            padding:
                const EdgeInsets.only(bottom: 13, left: 40, right: 40, top: 5),
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
                            bloc1.CreateCommentPost(postId, comment.text, date);
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
                  // HomeCubit.get(context)
                  //     .likePost(HomeCubit.get(context).postsId[index]);
                  var date = DateTime.now();
                  if (isPersonal) {
                    HomeCubit.get(context).likePost2(
                        HomeCubit.get(context).postsIdPersonal[index], date);
                  } else {
                    HomeCubit.get(context)
                        .likePost2(HomeCubit.get(context).postsId[index], date);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      if (isPersonal == false &&
                          (HomeCubit.get(context).posts[index].likes[
                                      HomeCubit.get(context).model!.uId] !=
                                  true ||
                              HomeCubit.get(context).posts[index].likes[
                                      HomeCubit.get(context).model!.uId] ==
                                  null))
                        Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ),
                      if (isPersonal == false &&
                          HomeCubit.get(context)
                                  .posts[index]
                                  .likes[HomeCubit.get(context).model!.uId] ==
                              true)
                        Icon(
                          Icons.favorite,
                          color: Colors.pink,
                        ),
                      if (isPersonal &&
                          (HomeCubit.get(context).postsPersonal[index].likes[
                                      HomeCubit.get(context).model!.uId] !=
                                  true ||
                              HomeCubit.get(context).postsPersonal[index].likes[
                                      HomeCubit.get(context).model!.uId] ==
                                  null))
                        Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ),
                      if (isPersonal &&
                          HomeCubit.get(context)
                                  .postsPersonal[index]
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
