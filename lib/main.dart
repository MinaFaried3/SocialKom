import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/login/login.dart';
import 'package:socialkom/shared/components/BlocObserver.dart';
import 'package:socialkom/shared/components/constants.dart';
import 'package:socialkom/shared/network/cache_helper.dart';
import 'package:socialkom/shared/network/dio_helper.dart';
import 'package:socialkom/shared/styles/color.dart';
import 'package:socialkom/shared/styles/theme.dart';

import 'Layout/MainCubit/mainCubit.dart';
import 'firebase_options.dart';
import 'modules/drawer/drawer.dart';
import 'modules/home/HomeStates.dart';
import 'modules/on_Bparding/onBoardingLiquid.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("on a background message: ${message.messageId}");
  print(message.data.toString());
  Fluttertoast.showToast(
    msg: 'on a background message ',
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 3,
    backgroundColor: social3,
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.Init_dio();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // var token = await FirebaseMessaging.instance.getToken();

  await FirebaseAnalytics.instance;
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    Fluttertoast.showToast(
      msg: 'on message ',
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 3,
      backgroundColor: social3,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
    );
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    Fluttertoast.showToast(
      msg: 'on Opened message ',
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 3,
      backgroundColor: social3,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
    );
  });

  await CacheHelper.init_shared();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool? isLightTheme = CacheHelper.getData(key: 'isLight');
  uId = CacheHelper.getData(key: 'uId');
  print("Uid is $uId");

  Widget? widget;
  if (onBoarding == null) {
    widget = liquidOnBoarding();
  } else {
    if (uId == null)
      widget = Login();
    else
      widget = MainPage();
  }
  BlocOverrides.runZoned(
    () async {
      runApp(Socialkom(
        widget: widget,
        isLightTheme: isLightTheme,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class Socialkom extends StatelessWidget {
  Widget? widget;
  final bool? isLightTheme;
  Socialkom({required this.widget, required this.isLightTheme});
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MainCubit()),
          BlocProvider(
              create: (context) => HomeCubit()
                ..changeThemeApp(fromShared: isLightTheme)
                ..getUserData()
                ..getPost()
                ..getStories()
                ..getPersonalStory2())
        ],
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: light,
              darkTheme: dark,
              themeMode: HomeCubit.get(context).isLight
                  ? ThemeMode.light
                  : ThemeMode.dark,
              home: widget,
            );
          },
        ));
  }
}
