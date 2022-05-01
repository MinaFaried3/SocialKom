import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/styles/color.dart';
import '../home/HomeCubit.dart';
import '../home/HomeStates.dart';

class CreateStory extends StatelessWidget {
  CreateStory({
    Key? key,
  }) : super(key: key);
  TextEditingController story = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is CreateStorySuccessState) {
        Navigator.pop(context);
        // HomeCubit.get(context).getPersonalStory2();
        Fluttertoast.showToast(
            msg: "Your story is created successfully",
            fontSize: 16,
            gravity: ToastGravity.BOTTOM,
            textColor: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: social3,
            toastLength: Toast.LENGTH_LONG);
      }
    }, builder: (context, state) {
      var bloc = HomeCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(bloc.StoryImage!),
                        fit: BoxFit.contain)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            HomeCubit.get(context).model!.image,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                HomeCubit.get(context).model!.name,
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
                        ),
                        IconButton(
                            onPressed: () {
                              bloc.closeStory();
                              Navigator.pop(context);
                              bloc.addText = false;
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
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: social3,
                                  )),
                            ))
                      ],
                    ),
                  ),
                  if (bloc.addText == true)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Center(
                        child: TextFormField(
                          controller: story,
                          maxLines: 6,
                          style: TextStyle(
                              height: 1.5, color: Colors.white, fontSize: 30),
                          decoration: InputDecoration(
                              hintText: "What's on your mind ...",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              bloc.AddText();
                              story.text = '';
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 9,
                                        spreadRadius: 4,
                                        offset: Offset(0, 4))
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.text_fields,
                                    color: social2,
                                  ),
                                  Text(
                                    !bloc.addText
                                        ? " add text"
                                        : " remove text",
                                    style: TextStyle(
                                        color: social2,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              var date = DateTime.now();
                              bloc.createStoryImage(
                                  date: date, text: story.text);
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 9,
                                        spreadRadius: 4,
                                        offset: Offset(0, 4))
                                  ]),
                              child: ConditionalBuilderRec(
                                condition: state is! CreateStoryLoadingState,
                                builder: (context) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.share_outlined,
                                      color: social2,
                                    ),
                                    Text(
                                      " share now",
                                      style: TextStyle(
                                          color: social2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                                fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: social3,
                                )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
