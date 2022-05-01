import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialkom/models/StoryMode.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/modules/story/ViewStory.dart';
import 'package:socialkom/shared/styles/color.dart';
import 'package:timeago/timeago.dart' as timeago;

class Story extends StatelessWidget {
  const Story({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = HomeCubit.get(context);
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: bloc.Stories.map((e) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewStory(e)));
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 230,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(e.storyImage),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(50),
                                        bottomLeft: Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .shadowColor
                                              .withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 9,
                                          offset: Offset(3, 3)),
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .shadowColor
                                              .withOpacity(0.4),
                                          spreadRadius: 3,
                                          blurRadius: 9,
                                          offset: Offset(-1, -1))
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          e.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          timeago.format(e.date),
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                      radius: 31,
                                      child: CircleAvatar(
                                        radius: 29,
                                        backgroundImage: NetworkImage(e.image),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )).toList(),
                    options: CarouselOptions(
                      reverse: false,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      viewportFraction: 1,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      initialPage: 0,
                      height: 240,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "My Stories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
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
                          height: 190,
                          margin: EdgeInsetsDirectional.only(start: 8),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(17)),
                          child: Column(
                            children: [
                              Container(
                                height: 153,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional.topCenter,
                                      child: Container(
                                        width: 110,
                                        height: 135,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(17),
                                              topLeft: Radius.circular(17),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
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
                        height: 190,
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => personalStoryItem(
                                context, bloc.personalStories2[index]),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 10,
                                ),
                            itemCount: bloc.personalStories2.length),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Friends Stories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1 / 1.5,
                    children: List.generate(bloc.Stories.length,
                        (index) => StoryItem(context, bloc.Stories[index])),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget personalStoryItem(context, StoryModel model) {
    var bloc = HomeCubit.get(context);
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
                      backgroundImage: NetworkImage(bloc.model!.image),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 110,
                    child: Text(
                      bloc.model!.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
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
