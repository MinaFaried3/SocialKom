import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialkom/modules/login/LoginCubit.dart';
import 'package:socialkom/modules/login/LoginState.dart';
import 'package:socialkom/shared/components/constants.dart';
import 'package:socialkom/shared/network/cache_helper.dart';
import 'package:socialkom/shared/styles/color.dart';

import '../Register/register.dart';
import '../drawer/drawer.dart';
import '../home/HomeCubit.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ErrorLogIn) {
            Fluttertoast.showToast(
                msg: state.error.toString(),
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red[400],
                timeInSecForIosWeb: 5,
                fontSize: 18);
          }
          if (state is SuccessLogIn) {
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
          var Bloc1 = LoginCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: AssetImage("image/login2.png"),
                  // width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 70),
                    height: 551,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 35),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "LOGIN",
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
                            Text(
                              "Login now to communicate with your friends !!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: social2,
                                      fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
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
                            // ConditionalBuilderRec(
                            //   condition: state is! LoadingLogIn,
                            //   // condition: false,
                            //   builder: (context) => Container(
                            //     width: double.infinity,
                            //     decoration: BoxDecoration(
                            //         color: CozmoColor2,
                            //         borderRadius: BorderRadius.circular(60)),
                            //     child: MaterialButton(
                            //       onPressed: () {
                            //         if (formKey.currentState!.validate()) {
                            //           Bloc1.PostData(
                            //               email: email.text,
                            //               password: password.text);
                            //           // if (state is SuccessLogIn) {
                            //           //   token = Bloc1.ShopLogin!.data!.token;
                            //           // }
                            //           // BlocProvider.of<ShopCubit>(context)
                            //           //     .GetHomeData();
                            //           // BlocProvider.of<ShopCubit>(context)
                            //           //     .GetFavoritesData();
                            //           // BlocProvider.of<ShopCubit>(context)
                            //           //     .GetCategoriesData();
                            //           // BlocProvider.of<ShopCubit>(context)
                            //           //     .GetCartData();
                            //           // BlocProvider.of<ShopCubit>(context)
                            //           //     .GetProfileData();
                            //         }
                            //       },
                            //       child: Text(
                            //         "LOGIN",
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 20,
                            //             letterSpacing: 2,
                            //             fontWeight: FontWeight.w600),
                            //       ),
                            //     ),
                            //   ),
                            //   fallback: (context) => Center(
                            //     child: CircularProgressIndicator(
                            //       color: CozmoColor2,
                            //     ),
                            //   ),
                            // ),
                            ConditionalBuilderRec(
                              condition: state is! LoadingLogIn,
                              builder: (context) => Container(
                                width: 230,
                                decoration: BoxDecoration(
                                    color: social4,
                                    borderRadius: BorderRadius.circular(60)),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      Bloc1.UserLogin(
                                          email: email.text,
                                          password: password.text);
                                    }
                                  },
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                color: social4,
                              )),
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
                Container(
                  height: 65,
                  margin: EdgeInsets.only(bottom: 115, left: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text(
                            "Register",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: social1,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2),
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
