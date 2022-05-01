import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';

import '../../models/PostMode.dart';
import '../../shared/styles/color.dart';

class EditPosts extends StatelessWidget {
  PostModel postModel;
  String postId;

  EditPosts({Key? key, required this.postModel, required this.postId})
      : super(key: key);
  TextEditingController post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      post.text = postModel.text!;

      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is EditPostSuccessState) {
            HomeCubit.get(context).getPost();
            HomeCubit.get(context).getPersonalPost2();
            Navigator.pop(context);
            HomeCubit.get(context).removePostImage();
            HomeCubit.get(context).isTranslate = false;
            HomeCubit.get(context).translateEditPost = '';
            HomeCubit.get(context).getPersonalPost2();
            Fluttertoast.showToast(
                msg: "Your post is Edited successfully",
                fontSize: 16,
                gravity: ToastGravity.BOTTOM,
                textColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: social3.withOpacity(0.7),
                toastLength: Toast.LENGTH_LONG);
          }
        },
        builder: (context, state) {
          var bloc = HomeCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    bloc.removePostImage();
                    bloc.isTranslate = false;
                    bloc.translateEditPost = '';
                  },
                  icon: Icon(Icons.arrow_back_ios_outlined),
                ),
                title: Text(
                  "Edit your post",
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: TextButton(
                        onPressed: () {
                          if (bloc.PostImage == null) {
                            bloc.editPost(
                                postModel: postModel,
                                postId: postId,
                                text: post.text);
                          } else {
                            bloc.editPostWithImage(
                                postModel: postModel,
                                postId: postId,
                                text: post.text);
                          }
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(
                              color: social3,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )),
                  )
                ]),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is EditPostLoadingState)
                      LinearProgressIndicator(
                        color: social3,
                      ),
                    if (state is EditPostLoadingState)
                      SizedBox(
                        height: 10,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 37,
                          backgroundImage:
                              NetworkImage(HomeCubit.get(context).model!.image),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    HomeCubit.get(context).model!.name,
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: social3,
                                    size: 23,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 26,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    child: MaterialButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.language_rounded,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Public",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 26,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    child: MaterialButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Album",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: post,
                      maxLines: 11,
                      style: TextStyle(height: 1.5),
                      onChanged: (text) {
                        if (bloc.isTranslate == true) {
                          bloc.translateEditPostTest(post.text);
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "What's on your mind ...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                    if (bloc.isTranslate == true &&
                        bloc.translateEditPost != '')
                      Flexible(
                        child: Text(
                          bloc.translateEditPost,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    if (bloc.isTranslate == false)
                      SizedBox(
                        height: 25,
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (bloc.PostImage != null || postModel.postImage != '')
                      Container(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        blurRadius: 9,
                                        spreadRadius: 4,
                                        offset: Offset(0, 4))
                                  ],
                                ),
                                child: bloc.PostImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                            image: FileImage(bloc.PostImage!),
                                            fit: BoxFit.contain),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                            image: NetworkImage(
                                                postModel.postImage!),
                                            fit: BoxFit.contain),
                                      ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  bloc.removePostImage();
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            blurRadius: 9,
                                            spreadRadius: 4,
                                            offset: Offset(0, 4))
                                      ]),
                                  child: CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: social3,
                                      )),
                                ))
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    if (bloc.PostImage == null && postModel.postImage == '')
                      SizedBox(
                        height: 250,
                      ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.4))),
                              child: MaterialButton(
                                  onPressed: () {
                                    bloc.getPostImage();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        color: social2,
                                      ),
                                      Text(
                                        " add photos",
                                        style: TextStyle(
                                            color: social2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 45,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.4))),
                              child: MaterialButton(
                                  onPressed: () {
                                    bloc.showTranslate();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (bloc.isTranslate == false)
                                        Icon(
                                          Icons.translate,
                                          color: social2,
                                        ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        bloc.isTranslate
                                            ? "Hide translate"
                                            : 'translate',
                                        style: TextStyle(
                                            color: social2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
