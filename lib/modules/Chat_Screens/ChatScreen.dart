import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialkom/models/CreateUser.dart';
import 'package:socialkom/models/MessageModel.dart';
import 'package:socialkom/modules/Chat_Screens/ChatDetails.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/shared/styles/color.dart';

import '../profile/FriendProfile.dart';

class ChatScreen extends StatelessWidget {
  UserModel model;
  ChatScreen(this.model);
  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();
    ScrollController? scrollController = ScrollController();

    return Builder(builder: (context) {
      if (HomeCubit.get(context).isFirst) {
        HomeCubit.get(context).getMessage(receiverId: model.uId);
        HomeCubit.get(context).doThis();
      }

      return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
        if (state is GetMessageSuccessState &&
            HomeCubit.get(context).messages != [])
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut);
      }, builder: (context, state) {
        var bloc = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatImage(model: model)));
                  },
                  child: CircleAvatar(
                      radius: 26, backgroundImage: NetworkImage(model.image)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(model.name)
              ],
            ),
            leadingWidth: 50,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                bloc.messages = [
                  MessageModel(
                      senderId: '',
                      receiverId: '',
                      dateTime: '',
                      text: "Chat  with your friend")
                ];
                bloc.isFirst = true;
                bloc.isMessage = false;
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    bloc.getFriendData(model.uId);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FriendProfile()));
                  },
                  icon: Icon(Icons.info_outline))
            ],
          ),
          body: ConditionalBuilderRec(
            condition: bloc.messages.length > 0,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index == bloc.messages.length) {
                          return Container(
                            height: 50,
                          );
                        }

                        var message = bloc.messages[index];
                        if (index == 0) {
                          return buildDefaultMessage(message, context);
                        }
                        if (bloc.model!.uId == message.senderId) {
                          return buildMYMessage(message);
                        }

                        return buildReceiverMessage(message);
                      },
                      separatorBuilder: (context, index) => SizedBox(),
                      itemCount: bloc.messages.length + 1),
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
                            controller: message,
                            keyboardType: TextInputType.text,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.black),
                            onChanged: (val) {
                              // if (message.text != null && message.text != '') {
                              //   bloc.changeMessageButton();
                              // }
                              // if (message.text == '' || message.text == null) {
                              //   bloc.isMessage = true;
                              //   bloc.isMessage2 = true;
                              // }
                            },
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
                            scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeOut);
                            bloc.sendMessage(
                                receiverId: model.uId,
                                dateTime: DateTime.now().toString(),
                                text: message.text);
                            bloc.isMessage = false;

                            message.clear();
                          },
                          icon: Icon(
                            FontAwesomeIcons.rocketchat,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
    });
  }

  Widget buildReceiverMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1.5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(15),
                  topEnd: Radius.circular(15),
                  bottomEnd: Radius.circular(15),
                )),
            child: Text(message.text,
                style: TextStyle(fontWeight: FontWeight.w600))),
      );
  Widget buildMYMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1.5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: social5,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(15),
                  topEnd: Radius.circular(15),
                  bottomStart: Radius.circular(15),
                )),
            child: Text(
              message.text,
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
      );
  Widget buildDefaultMessage(MessageModel message, context) => Align(
        alignment: AlignmentDirectional.topCenter,
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
              color: social4, borderRadius: BorderRadius.circular(20)),
          child: Text(
            message.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
      );
}
