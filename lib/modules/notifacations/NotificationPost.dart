import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';

import '../../shared/styles/color.dart';

class NotificationPostScreen extends StatelessWidget {
  late String postId;
  NotificationPostScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    TextEditingController comment = TextEditingController();
    return Builder(
      builder: (context) {
        HomeCubit.get(context).getNotificationPost(postId);
        HomeCubit.get(context).getCommentPost(postId);
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is SavePostSuccessState) {
              Navigator.pop(context);
            }
            if (state is SavedToGalleryLoadingState) {
              Navigator.pop(context);
            }
            if (state is SavedToGallerySuccessState) {
              Fluttertoast.showToast(
                  msg: "Downloaded to Gallery!",
                  gravity: ToastGravity.CENTER,
                  backgroundColor: social3.withOpacity(0.7),
                  timeInSecForIosWeb: 5,
                  fontSize: 18);
            }
          },
          builder: (context, state) {
            var bloc = HomeCubit.get(context);
            var model = HomeCubit.get(context).postNotificationModel;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    HomeCubit.get(context).postNotificationModel = null;
                    bloc.transNotificationPost = '';
                    bloc.getNotifications();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                  ),
                ),
                title: Text(
                  "Post",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              body: ConditionalBuilderRec(
                condition: bloc.postNotificationModel != null &&
                    state is! GetPostLoadingState,
                builder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Card(
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
                                    backgroundImage: NetworkImage(model!.image),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text(model.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
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
                                        style:
                                            Theme.of(context).textTheme.caption,
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
                                        bloc.translateNotificationPost(
                                            model.text!);
                                      },
                                      icon: Icon(
                                        Icons.translate,
                                        color: social1,
                                      )),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(30))),
                                          builder: (context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      bloc.savePost(
                                                          postId: postId,
                                                          date: DateTime.now(),
                                                          userName: model.name,
                                                          userId: model.uId,
                                                          userImage:
                                                              model.image,
                                                          postText: model.text,
                                                          postImage:
                                                              model.postImage);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .turned_in_not_sharp,
                                                            color: social1,
                                                            size: 30,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Save Post",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                                        bloc.saveToGallery(
                                                            model.postImage!);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .save_outlined,
                                                              color: social1,
                                                              size: 30,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Save Post Image",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .share,
                                                            color: social1,
                                                            size: 30,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Share",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 15),
                              ),
                            if (model.text != '' &&
                                bloc.transNotificationPost != '')
                              SizedBox(
                                height: 10,
                              ),
                            if (model.text != '' &&
                                bloc.transNotificationPost != '')
                              Text(
                                bloc.transNotificationPost,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 15, color: Colors.grey),
                              ),
                            if (model.text != '' &&
                                bloc.transNotificationPost != '')
                              SizedBox(
                                height: 10,
                              ),
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
                                      image: NetworkImage(model.postImage!),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
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
                                            "${model.likesNum!.length}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
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
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.comment_outlined,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${model.comments.length} ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                          Text(
                                            "comments",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "comments",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => commentItem(
                                    context, bloc.Comments[index], index),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10,
                                    ),
                                itemCount: bloc.Comments.length),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 17,
                                          backgroundImage: NetworkImage(
                                              HomeCubit.get(context)
                                                  .model!
                                                  .image),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller: comment,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'write a comment .....',
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(fontSize: 15)),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            var date = DateTime.now();
                                            if (comment.text != '')
                                              bloc.CreateCommentPost(
                                                  postId, comment.text, date);
                                            bloc.getCommentPost(postId);
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
                                    bloc.likePost2(postId, date);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        if (model.likes[HomeCubit.get(context)
                                                    .model!
                                                    .uId] !=
                                                true ||
                                            model.likes[HomeCubit.get(context)
                                                    .model!
                                                    .uId] ==
                                                null)
                                          Icon(
                                            Icons.favorite_border,
                                            color: Colors.grey,
                                          ),
                                        if (model.likes[HomeCubit.get(context)
                                                .model!
                                                .uId] ==
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
                                              .subtitle2,
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
                    ),
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget commentItem(context, String Comment, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(HomeCubit.get(context).CommentsUserImages[index]),
            radius: 29,
          ),
          Flexible(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1.5),
                padding:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
                decoration: BoxDecoration(
                    color: social5,
                    borderRadius: BorderRadiusDirectional.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      HomeCubit.get(context).CommentsUserName[index],
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      Comment,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
