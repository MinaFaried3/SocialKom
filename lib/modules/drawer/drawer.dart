import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:socialkom/modules/drawer/drawerWidget.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/shared/styles/color.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          var bloc = HomeCubit.get(context);
          return ZoomDrawer(
              style: DrawerStyle.Style1,
              borderRadius: 40,
              angle: -10,
              showShadow: true,
              backgroundColor: bloc.isLight ? social1 : social4,
              menuScreen: Builder(builder: (context) {
                return MenuPage(
                    currentItem: bloc.currentItem,
                    onSelectedItem: (item) {
                      bloc.changeItem(item, context);
                      ZoomDrawer.of(context)!.close();
                    });
              }),
              mainScreen: bloc.MenuScreen);
        },
        listener: (context, state) {});
  }
}
