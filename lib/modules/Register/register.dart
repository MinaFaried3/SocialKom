import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialkom/modules/Register/registerCubit.dart';
import 'package:socialkom/modules/Register/registerState.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/color.dart';
import '../drawer/drawer.dart';
import '../home/HomeCubit.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is ErrorCreateRegister) {
            Fluttertoast.showToast(
                msg: state.error.toString(),
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                fontSize: 18);
          }
          if (state is ErrorRegister) {
            Fluttertoast.showToast(
                msg: state.error.toString(),
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 5,
                fontSize: 18);
          }
          if (state is SuccessCreateRegister) {
            Fluttertoast.showToast(
                msg: "welcome with you",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: social3,
                timeInSecForIosWeb: 5,
                fontSize: 18);
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              HomeCubit.get(context).getUserData();
              if (HomeCubit.get(context).model != null) {
                CacheHelper.saveData(
                        key: 'isLight',
                        value: HomeCubit.get(context).model!.theme)
                    .then((value) {
                  HomeCubit.get(context).getPost();
                  HomeCubit.get(context).getStories();
                  HomeCubit.get(context).getPersonalStory2();
                });
              }

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                  (route) => false);
            });
          }
        },
        builder: (context, state) {
          var Bloc1 = RegisterCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  image: AssetImage("image/register2.png"),
                  // width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 170),
                      height: 760,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 35),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "REGISTER",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: social4,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 350,
                                child: Text(
                                  "Register now to communicate with your friends !!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: social2,
                                          fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        2.31,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 3,
                                              blurRadius: 9,
                                              offset: Offset(0, 0))
                                        ]),
                                    child: TextFormField(
                                      controller: name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      onFieldSubmitted: (val) {
                                        //   if (formKey.currentState!.validate()) {
                                        //     Bloc1.PostData(
                                        //         email: email.text, password: password.text);
                                        //   }
                                        // },
                                        // validator: (String? val) {
                                        //   if (val!.isEmpty) {
                                        //     return "Please Enter your email address..";
                                        //   }
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
                                                  color: Colors.transparent,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      cursorColor: social1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        2.31,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 3,
                                              blurRadius: 9,
                                              offset: Offset(0, 0))
                                        ]),
                                    child: TextFormField(
                                      controller: phone,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.black),
                                      keyboardType: TextInputType.phone,
                                      onFieldSubmitted: (val) {
                                        //   if (formKey.currentState!.validate()) {
                                        //     Bloc1.PostData(
                                        //         email: email.text, password: password.text);
                                        //   }
                                        // },
                                        // validator: (String? val) {
                                        //   if (val!.isEmpty) {
                                        //     return "Please Enter your email address..";
                                        //   }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Phone",
                                          hintStyle: TextStyle(color: social2),
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: social4,
                                          ),
                                          // border: OutlineInputBorder(),
                                          focusColor: social1,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      cursorColor: social1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 9,
                                          offset: Offset(0, 0))
                                    ]),
                                child: TextFormField(
                                  controller: email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  onFieldSubmitted: (val) {
                                    //   if (formKey.currentState!.validate()) {
                                    //     Bloc1.PostData(
                                    //         email: email.text, password: password.text);
                                    //   }
                                    // },
                                    // validator: (String? val) {
                                    //   if (val!.isEmpty) {
                                    //     return "Please Enter your email address..";
                                    //   }
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
                                              color: Colors.transparent,
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  cursorColor: social1,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 9,
                                          offset: Offset(0, 0))
                                    ]),
                                child: TextFormField(
                                  controller: password,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.black),
                                  obscureText: Bloc1.isHidePassword,
                                  onFieldSubmitted: (val) {
                                    // if (formKey.currentState!.validate()) {
                                    //   Bloc1.PostData(
                                    //       email: email.text, password: password.text);
                                    // }
                                  },
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Please ,Enter your password..";
                                    }
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: social2),
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: social4,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          Bloc1.changePassword();
                                        },
                                        icon: Icon(
                                          Bloc1.password,
                                          color: social4,
                                        ),
                                        highlightColor: social1,
                                      ),
                                      // border: OutlineInputBorder(),
                                      focusColor: social1,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  cursorColor: social1,
                                  cursorRadius: Radius.circular(60),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ConditionalBuilderRec(
                  condition: state is! LoadingRegister,
                  builder: (context) => Container(
                    margin: EdgeInsets.only(bottom: 60, left: 250),
                    decoration: BoxDecoration(
                        color: social1,
                        borderRadius: BorderRadius.circular(60)),
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Bloc1.UserRegister(
                              email: email.text,
                              password: password.text,
                              name: name.text,
                              phone: phone.text);
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  fallback: (context) => Container(
                    margin: EdgeInsets.only(bottom: 69, left: 250),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(60)),
                    child: CircularProgressIndicator(
                      color: social1,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
