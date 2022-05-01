import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialkom/models/StoryMode.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../shared/styles/color.dart';
import '../profile/FriendProfile.dart';

class ViewStory extends StatelessWidget {
  StoryModel? model;
  ViewStory(this.model);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
                child: Stack(
              children: [
                SizedBox.expand(
                  child: InteractiveViewer(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(model!.storyImage),
                              fit: BoxFit.contain)),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 9,
                                          spreadRadius: 4,
                                          offset: Offset(0, 4))
                                    ]),
                                child: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: Icon(
                                      Icons.arrow_back_ios_outlined,
                                      color: social3,
                                    )),
                              )),
                          InkWell(
                            onTap: () {
                              if (model!.uId != bloc.model!.uId) {
                                bloc.getFriendData(model!.uId);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FriendProfile()));
                              } else {
                                bloc.changeIndex(4, context);
                                Navigator.pop(context);
                              }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                model!.image,
                              ),
                            ),
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
                                      model!.name,
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
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
                                  height: 5,
                                ),
                                Text(
                                  timeago.format(model!.date),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Flexible(
                        child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          if (model!.text != "")
                            Center(
                                child: Text(
                              model!.text!,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                          MaterialButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "REPLAY",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ))
                  ],
                )
              ],
            )),
          );
        });
  }
}
