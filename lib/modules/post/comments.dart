import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';

import '../../shared/styles/color.dart';

class CommentsScreen extends StatelessWidget {
  late int likesNumber;
  late int index;
  bool? isPersonal;
  late String postId;
  CommentsScreen(
      {required this.likesNumber,
      this.isPersonal,
      required this.postId,
      required this.index});

  @override
  Widget build(BuildContext context) {
    TextEditingController comment = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      "$likesNumber",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    if (isPersonal == false &&
                        (HomeCubit.get(context)
                                    .posts[index]
                                    .likes[HomeCubit.get(context).model!.uId] !=
                                true ||
                            HomeCubit.get(context)
                                    .posts[index]
                                    .likes[HomeCubit.get(context).model!.uId] ==
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
                    if (isPersonal! &&
                        (HomeCubit.get(context)
                                    .postsPersonal[index]
                                    .likes[HomeCubit.get(context).model!.uId] !=
                                true ||
                            HomeCubit.get(context)
                                    .postsPersonal[index]
                                    .likes[HomeCubit.get(context).model!.uId] ==
                                null))
                      Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                    if (isPersonal! &&
                        HomeCubit.get(context)
                                .postsPersonal[index]
                                .likes[HomeCubit.get(context).model!.uId] ==
                            true)
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                  ],
                ),
              )
            ],
          ),
          body: ConditionalBuilderRec(
            condition: state is! GetCommentsLoadingState,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            commentItem(context, bloc.Comments[index], index),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: bloc.Comments.length),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsetsDirectional.only(
                              top: 7, end: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 6,
                                    offset: Offset(0, 0))
                              ]),
                          child: TextFormField(
                            controller: comment,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.black),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "type here...",
                                hintStyle: TextStyle(color: Colors.grey),

                                // border: OutlineInputBorder(),
                                focusColor: social1,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 3),
                                    borderRadius: BorderRadius.circular(30)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 3),
                                    borderRadius: BorderRadius.circular(30))),
                            cursorColor: social1,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: social2,
                        child: IconButton(
                            onPressed: () {
                              var date = DateTime.now();
                              try {
                                bloc.CreateCommentPost(
                                    postId, comment.text, date);
                              } catch (error) {}
                            },
                            icon: Icon(
                              Icons.send_outlined,
                              color: Colors.white,
                              size: 32,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
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
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(20),
                      bottomEnd: Radius.circular(20),
                      bottomStart: Radius.circular(20),
                    )),
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
