import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:socialkom/models/drawerModel.dart';
import 'package:socialkom/modules/drawer/drawerItems.dart';
import 'package:socialkom/modules/login/login.dart';
import 'package:socialkom/shared/network/cache_helper.dart';

import '../../shared/components/constants.dart';
import '../../shared/styles/color.dart';
import '../home/HomeCubit.dart';
import '../home/HomeStates.dart';

class MenuPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  const MenuPage(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          var bloc = HomeCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor:
                bloc.isLight ? Color(0xff063750) : Color(0xff022131),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    ...MenuItems.all.map(buildMenuItem).toList(),
                    if (bloc.model != null)
                      Container(
                        width: 120,
                        child: FlutterSwitch(
                          duration: Duration(milliseconds: 500),
                          width: 90.0,
                          height: 45.0,
                          toggleSize: 40.0,
                          value: bloc.isLight,
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
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        CacheHelper.removeData(key: 'uId').then((value) {
                          if (value!) {
                            uId = null;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.logout,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (bloc.model != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white24,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(bloc.model!.image),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bloc.model!.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    bloc.model!.email,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget buildMenuItem(MenuItem item) => ListTile(
        selected: currentItem == item,
        selectedTileColor: Colors.black26,
        minLeadingWidth: 30,
        leading: Icon(
          item.icon,
          color: Colors.white,
        ),
        title: Text(
          item.title,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onTap: () {
          return onSelectedItem(item);
        },
      );
}
