import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/shared/styles/color.dart';

import '../../models/CreateUser.dart';
import '../profile/FriendProfile.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = HomeCubit.get(context);
        return Scaffold(
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
              "Search",
              style: TextStyle(fontSize: 25),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Center(
                            child: TextFormField(
                              controller: search,
                              decoration: InputDecoration(
                                  hintText: "Search ......",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontSize: 18),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: social3, width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: social3, width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: social3, width: 2),
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        radius: 25,
                        child: IconButton(
                          onPressed: () {
                            bloc.getSearchUsers(search.text);
                          },
                          icon: CircleAvatar(
                              radius: 60,
                              child: Icon(
                                Icons.search,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              )),
                        ),
                      )
                    ],
                  ),
                  ConditionalBuilderRec(
                    condition: state is! GetAllSearchUserLoadingState,
                    builder: (context) => Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) =>
                              ChatItem(context, bloc.usersSearch[index]),
                          separatorBuilder: (context, index) => SizedBox(),
                          itemCount: bloc.usersSearch.length),
                    ),
                    fallback: (context) => LinearProgressIndicator(
                      color: social3,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget ChatItem(context, UserModel model) {
    var bloc1 = HomeCubit.get(context);
    return InkWell(
      onTap: () {
        if (model.uId == bloc1.model!.uId) {
          bloc1.changeIndex(4, context);
          Navigator.pop(context);
        } else {
          bloc1.getFriendData(model.uId);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FriendProfile()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(model.image),
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
                        model.name,
                        style: Theme.of(context).textTheme.headline5,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                ],
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 4))
                    ]),
                    child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: Icon(
                          Icons.person_add_alt,
                          color: social3,
                        )),
                  ),
                  // radius: 25,
                ))
          ],
        ),
      ),
    );
  }
}
