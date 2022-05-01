import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/shared/styles/color.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController bio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is UpdateSuccessState) {
          Fluttertoast.showToast(
              msg: "Your info is updated",
              fontSize: 16,
              gravity: ToastGravity.BOTTOM,
              textColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundColor: social3,
              toastLength: Toast.LENGTH_LONG);
        }
      },
      builder: (context, state) {
        var bloc = HomeCubit.get(context);
        var blocProfileImage = HomeCubit.get(context).ProfileImage;
        var blocCoverImage = HomeCubit.get(context).CoverImage;
        name.text = bloc.model!.name;
        email.text = bloc.model!.email;
        phone.text = bloc.model!.phone;
        bio.text = bloc.model!.bio;
        // bool theme = bloc.model!.theme;

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
              "Edit Profile",
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: TextButton(
                    onPressed: () {
                      if (bloc.ProfileImage != null && bloc.CoverImage == null)
                        bloc.uploadProfile(
                            email: email.text,
                            name: name.text,
                            phone: phone.text,
                            bio: bio.text,
                            theme: bloc.model!.theme);
                      else if (bloc.CoverImage != null &&
                          bloc.ProfileImage == null)
                        bloc.uploadCover(
                            email: email.text,
                            name: name.text,
                            phone: phone.text,
                            bio: bio.text,
                            theme: bloc.model!.theme);
                      else if (bloc.ProfileImage == null &&
                          bloc.CoverImage == null)
                        bloc.updateUserData(
                            email: email.text,
                            name: name.text,
                            phone: phone.text,
                            bio: bio.text,
                            theme: bloc.model!.theme);
                      else if (bloc.ProfileImage != null &&
                          bloc.CoverImage != null)
                        bloc.uploadProfileAndCover(
                            email: email.text,
                            name: name.text,
                            phone: phone.text,
                            bio: bio.text,
                            theme: bloc.model!.theme);
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                          color: social3,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Column(
                children: [
                  if (state is UpdateLoadingState)
                    LinearProgressIndicator(
                      color: social3,
                    ),
                  if (state is UpdateLoadingState)
                    SizedBox(
                      height: 8,
                    ),
                  Container(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                    image: blocCoverImage == null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                bloc.model!.background),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: FileImage(blocCoverImage),
                                            fit: BoxFit.cover)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    bloc.getCoverImage();
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .shadowColor
                                                  .withOpacity(0.5),
                                              blurRadius: 9,
                                              spreadRadius: 4,
                                              offset: Offset(0, 4))
                                        ]),
                                    child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Icon(
                                          Icons.camera_enhance_outlined,
                                          color: social4,
                                        )),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: blocProfileImage == null
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          NetworkImage(bloc.model!.image),
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          FileImage(blocProfileImage),
                                    ),
                            ),
                            IconButton(
                                onPressed: () {
                                  bloc.getProfileImage();
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .shadowColor
                                                .withOpacity(0.4),
                                            blurRadius: 9,
                                            spreadRadius: 4,
                                            offset: Offset(0, 4))
                                      ]),
                                  child: CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Icon(
                                        Icons.camera_enhance_outlined,
                                        color: social4,
                                      )),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset: Offset(3, 3))
                        ]),
                    child: TextFormField(
                      controller: name,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (val) {},
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Please Enter your name address..";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(color: social2),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: social4,
                          ),
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset: Offset(3, 3))
                        ]),
                    child: TextFormField(
                      controller: email,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (val) {},
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Please Enter your email address..";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: social2),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: social4,
                          ),
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset: Offset(3, 3))
                        ]),
                    child: TextFormField(
                      controller: phone,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (val) {},
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Please Enter your phone address..";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Phone",
                          hintStyle: TextStyle(color: social2),
                          prefixIcon: Icon(
                            Icons.local_phone_outlined,
                            color: social4,
                          ),
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset: Offset(3, 3))
                        ]),
                    child: TextFormField(
                      controller: bio,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (val) {},
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Please Enter your bio address..";
                        }
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: "Bio",
                          hintStyle: TextStyle(color: social2),
                          prefixIcon: Icon(
                            Icons.edit_location_outlined,
                            color: social4,
                          ),
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 90.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset: Offset(0, 0))
                        ]),
                    child: FlutterSwitch(
                      width: 90.0,
                      height: 45.0,
                      toggleSize: 40.0,
                      value: bloc.model!.theme,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: social3,
                      inactiveToggleColor: social3,
                      activeSwitchBorder: Border.all(
                        color: Color(0xFFD1D5DA),
                        width: 3.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: Color(0xFF31125E),
                        width: 3.0,
                      ),
                      activeColor: Colors.white,
                      inactiveColor: Color(0xFF0C0224),
                      activeIcon: Icon(
                        Icons.wb_sunny,
                        color: Color(0xFFFFDF5D),
                      ),
                      inactiveIcon: Icon(
                        Icons.nightlight_round,
                        color: Color(0xFFF8E3A1),
                      ),
                      onToggle: (val) {
                        bloc.changeThemeApp();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
