import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialkom/models/NotificationModel.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/shared/styles/color.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'NotificationPost.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = HomeCubit.get(context);
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ConditionalBuilderRec(
            condition: bloc.notifications.length > 0 &&
                state is! GetNotificationsLoadingState,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildNotificationItem(
                          context, bloc.notifications[index]),
                      separatorBuilder: (context, index) => SizedBox(),
                      itemCount: bloc.notifications.length),
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildNotificationItem(context, NotificationModel notification) {
    var bloc = HomeCubit.get(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationPostScreen(
                      postId: notification.postId,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(notification.userImage),
                    ),
                  ),
                ),
                if (notification.notificationType == 'like')
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 19,
                        ),
                        backgroundColor: Colors.pink,
                      ),
                    ),
                  ),
                if (notification.notificationType == 'save')
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(
                          Icons.turned_in_not_sharp,
                          color: Colors.white,
                          size: 19,
                        ),
                        backgroundColor: Colors.teal,
                      ),
                    ),
                  ),
                if (notification.notificationType == 'comment')
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(
                          Icons.comment_outlined,
                          color: Colors.white,
                          size: 19,
                        ),
                        backgroundColor: Colors.amber,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 7,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 22),
                  ),
                  Row(
                    children: [
                      Text(
                        notification.event,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: social4,
                        ),
                      ),
                      Text(
                        timeago.format(notification.date, locale: 'en_short'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (notification.postImage != '')
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: Offset(-3, 3)),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(notification.postImage!),
                        fit: BoxFit.cover)),
              )
          ],
        ),
      ),
    );
  }
}
