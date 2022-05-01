import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';

import '../../models/StoryMode.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/color.dart';
import '../post/post.dart';
import '../story/ViewStory.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ConditionalBuilderRec(
            condition: bloc.posts.length > 0 && bloc.model != null,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration:
                          BoxDecoration(color: Colors.amber.withOpacity(0.5)),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_outlined),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Please verify your email !!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((value) {
                                  Fluttertoast.showToast(
                                    msg: 'Check your mail Now...',
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: social3,
                                    textColor: Colors.white,
                                    timeInSecForIosWeb: 5,
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                }).catchError((error) {
                                  print(error.toString());
                                });
                              },
                              child: Text(
                                "Verify",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: social4,
                                    fontWeight: FontWeight.w600),
                              )),
                        ],
                      ),
                    ),
                  CarouselSlider(
                      items: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 6,
                          margin: EdgeInsets.all(8),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                image: AssetImage("image/pic6.jpg"),
                                fit: BoxFit.cover,
                                height: 190,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Communicate with friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 6,
                          margin: EdgeInsets.all(8),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                image: AssetImage("image/pic2.jpg"),
                                fit: BoxFit.cover,
                                height: 190,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Communicate with friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 6,
                          margin: EdgeInsets.all(8),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                image: AssetImage("image/pic3.jpg"),
                                fit: BoxFit.cover,
                                height: 190,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Communicate with friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 6,
                          margin: EdgeInsets.all(8),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                image: AssetImage("image/pic5.jpg"),
                                fit: BoxFit.cover,
                                height: 190,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Communicate with friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 6,
                          margin: EdgeInsets.all(8),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                image: AssetImage("image/pic7.jpg"),
                                fit: BoxFit.cover,
                                height: 190,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Communicate with friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                          height: 190,
                          enableInfiniteScroll: true,
                          viewportFraction: 1,
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                          reverse: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(seconds: 2))),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            bloc.getStoryImage(context);
                          },
                          child: Container(
                            width: 110,
                            height: 180,
                            margin: EdgeInsetsDirectional.only(start: 8),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(17)),
                            child: Column(
                              children: [
                                Container(
                                  height: 153,
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: Container(
                                          width: 110,
                                          height: 135,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(17),
                                                topLeft: Radius.circular(17),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      bloc.model!.image),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.3),
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: social3,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Create Story",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 180,
                          child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              reverse: true,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  StoryItem(context, bloc.Stories[index]),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10,
                                  ),
                              itemCount: bloc.Stories.length),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 3,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              bloc.changeIndex(4, context);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(bloc.model!.image),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(color: Colors.grey)),
                              child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Post()));
                                  },
                                  child: Text(
                                    "What's on your mind ?",
                                    style: TextStyle(color: social2),
                                  )),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                bloc.getPostFeedsImage(context);
                              },
                              icon: Icon(
                                Icons.photo_library_outlined,
                                color: social2,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                          context, bloc.posts[index], index,
                          isPersonal: false),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 13,
                          ),
                      itemCount: bloc.posts.length),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget StoryItem(context, StoryModel model) {
    var bloc = HomeCubit.get(context).model;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewStory(model)));
      },
      child: Container(
        width: 110,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(17)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: NetworkImage(model.storyImage),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 23,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: model.uId == bloc!.uId
                          ? NetworkImage(bloc.image)
                          : NetworkImage(model.image),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 110,
                    height: 25,
                    child: Text(
                      model.uId == bloc.uId ? bloc.name : model.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
