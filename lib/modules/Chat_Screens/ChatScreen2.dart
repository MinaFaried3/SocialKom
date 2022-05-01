import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialkom/models/SavedPostModel.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/shared/styles/color.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/CreateUser.dart';
import '../notifacations/NotificationPost.dart';

class ChatScreen2 extends StatelessWidget {
  UserModel model;
  ChatScreen2({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getSavedPosts();
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    try {
                      ZoomDrawer.of(context)!.toggle();
                    } catch (error) {
                      Navigator.pop(context);
                      print(error.toString());
                    }
                  },
                  icon: Icon(FontAwesomeIcons.alignLeft),
                ),
                title: Text(
                  "Saved",
                  style: TextStyle(fontSize: 25),
                )),
            body: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ConditionalBuilderRec(
                condition: bloc.savedPosts.length > 0,
                builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                          reverse: true,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildSavedPostImageText(context,
                                  bloc.savedPostsWithImagesWithText[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: bloc.savedPostsWithImagesWithText.length),
                      CarouselSlider(
                          items: bloc.savedPostsWithImages.reversed
                              .map((e) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationPostScreen(
                                                    postId: e.postId,
                                                  )));
                                    },
                                    child: Container(
                                      height: 160,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (e.postImage != '')
                                            Container(
                                              width: 200,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          e.postImage!),
                                                      fit: BoxFit.cover),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Theme.of(context)
                                                            .shadowColor
                                                            .withOpacity(0.5),
                                                        blurRadius: 9,
                                                        spreadRadius: 2,
                                                        offset: Offset(-3, 5))
                                                  ]),
                                            ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage:
                                                      NetworkImage(e.userImage),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          e.userName,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .subtitle2!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 4,
                                                              backgroundColor:
                                                                  social4,
                                                            ),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                              'Saved From ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                                timeago.format(
                                                                    e.date,
                                                                    locale:
                                                                        'en_short'),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle2!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w700)),
                                                            Text(' ago',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            reverse: false,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            viewportFraction: 1,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            initialPage: 0,
                            height: 190,
                          )),
                      ListView.separated(
                          reverse: true,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildSavedPostText(
                              context, bloc.savedPostsWithText[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: bloc.savedPostsWithText.length),
                      ListView.separated(
                          reverse: true,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildSavedPostImage(
                              context, bloc.savedPostsWithImages[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: bloc.savedPostsWithImages.length),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildSavedPostImageText(context, SavedPostModel model) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationPostScreen(
                      postId: model.postId,
                    )));
      },
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (model.postImage != '')
              Container(
                width: 140,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(model.postImage!),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.5),
                          blurRadius: 9,
                          spreadRadius: 2,
                          offset: Offset(-3, 5))
                    ]),
              ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.postText!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            model.userName,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: social4,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Saved From ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                  timeago.format(model.date,
                                      locale: 'en_short'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontWeight: FontWeight.w700)),
                              Text(' ago',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(model.userImage),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSavedPostImage(context, SavedPostModel model) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationPostScreen(
                      postId: model.postId,
                    )));
      },
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (model.postImage != '')
              Container(
                width: 170,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(model.postImage!),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.5),
                          blurRadius: 9,
                          spreadRadius: 2,
                          offset: Offset(-3, 5))
                    ]),
              ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(model.userImage),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            model.userName,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: social4,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Saved From ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                  timeago.format(model.date,
                                      locale: 'en_short'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontWeight: FontWeight.w700)),
                              Text(' ago',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSavedPostText(context, SavedPostModel model) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationPostScreen(
                      postId: model.postId,
                    )));
      },
      child: Container(
        height: 130,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(model.userImage),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 3,
                  height: 40,
                  color: social3,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    model.postText!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 17),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      model.userName,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: social4,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          'Saved From ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(timeago.format(model.date, locale: 'en_short'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.w700)),
                        Text(' ago',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
