import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialkom/models/CreateUser.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';

import '../../shared/styles/color.dart';
import '../Chat_Screens/ChatScreen.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = HomeCubit.get(context);
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ConditionalBuilderRec(
            condition: bloc.users.length > 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    ChatItem(context, bloc.users[index]),
                separatorBuilder: (context, index) => SizedBox(),
                itemCount: bloc.users.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget ChatItem(context, UserModel model) {
    var bloc1 = HomeCubit.get(context);
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatScreen(model)));
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
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 4))
                    ]),
                    child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: social3,
                        )),
                  ),
                  radius: 18,
                ))
          ],
        ),
      ),
    );
  }
}
