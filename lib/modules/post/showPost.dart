import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialkom/models/PostMode.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';

import 'comments.dart';

class ShowPost extends StatelessWidget {
  final PostModel post;
  final String postId;
  final bool isPersonal;
  final int index;
  const ShowPost(
      {Key? key,
      required this.post,
      required this.postId,
      required this.index,
      required this.isPersonal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: InteractiveViewer(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(post.postImage!),
                        fit: BoxFit.contain)),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: Container(
                color: Colors.black.withOpacity(0.3),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (post.text != "")
                      Text(
                        post.text!,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat.yMMMd().format(post.date),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
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
                                    "${post.likesNum!.length}",
                                    style: TextStyle(color: Colors.white),
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
                              HomeCubit.get(context).getCommentPost(postId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentsScreen(
                                            likesNumber: post.likesNum!.length,
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
                                    "${post.comments.length} ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "comments",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
