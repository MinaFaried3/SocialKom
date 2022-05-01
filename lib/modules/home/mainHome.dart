import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialkom/modules/home/HomeCubit.dart';
import 'package:socialkom/modules/home/HomeStates.dart';
import 'package:socialkom/modules/post/post.dart';

import '../../shared/styles/color.dart';
import '../drawer/drawerWidget.dart';
import '../search/search.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = HomeCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            appBar: AppBar(
              titleSpacing: 0,
              leading: IconButton(
                onPressed: () {
                  try {
                    ZoomDrawer.of(context)!.toggle();
                  } catch (error) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuPage(
                                currentItem: bloc.currentItem,
                                onSelectedItem: (item) {
                                  bloc.changeItem(item, context);
                                  ZoomDrawer.of(context)!.close();
                                })));

                    print(error.toString());
                  }
                },
                icon: Icon(FontAwesomeIcons.alignLeft),
              ),
              title: bloc.current != 4
                  ? bloc.Titles[bloc.current]
                  : Text(bloc.model!.name),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Post()));
                  },
                  icon: Icon(Icons.add_photo_alternate_outlined),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
            body: ConditionalBuilderRec(
              condition: bloc.model != null,
              builder: (context) {
                var model = bloc.model;
                return bloc.Screens[bloc.current];
              },
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              color: social1.withOpacity(0.7),
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              height: 50,
              buttonBackgroundColor: social4.withOpacity(0.7),
              index: bloc.current,
              onTap: (index) {
                bloc.changeIndex(index, context);
                print(bloc.current);
              },
              items: [
                Icon(
                  Icons.home,
                  size: 26,
                  color: bloc.current == 0
                      ? Colors.white
                      : Colors.black.withOpacity(0.6),
                ),
                Icon(
                  Icons.chat,
                  size: 26,
                  color: bloc.current == 1
                      ? Colors.white
                      : Colors.black.withOpacity(0.6),
                ),
                Icon(
                  Icons.notifications_active,
                  size: 26,
                  color: bloc.current == 2
                      ? Colors.white
                      : Colors.black.withOpacity(0.6),
                ),
                Icon(
                  Icons.camera,
                  size: 26,
                  color: bloc.current == 3
                      ? Colors.white
                      : Colors.black.withOpacity(0.6),
                ),
                ConditionalBuilderRec(
                  condition: bloc.model != null,
                  builder: (context) => CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(bloc.model!.image),
                  ),
                  fallback: (context) => Icon(
                    Icons.person_outline,
                    size: 26,
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

  Widget drawer(context) {
    var bloc = HomeCubit.get(context);
    return ZoomDrawer(
        style: DrawerStyle.Style1,
        borderRadius: 40,
        angle: -10,
        showShadow: true,
        backgroundColor: social1,
        menuScreen: Builder(builder: (context) {
          return MenuPage(
              currentItem: bloc.currentItem,
              onSelectedItem: (item) {
                bloc.changeItem(item, context);
                ZoomDrawer.of(context)!.close();
              });
        }),
        mainScreen: bloc.MenuScreen);
  }

  Widget bottomNavBar(context) {
    var bloc = HomeCubit.get(context);
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // color: Theme.of(context).scaffoldBackgroundColor,
        // color: Colors.transparent,
        borderRadius: BorderRadius.circular(37),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(37),
        child: BottomNavigationBar(
          backgroundColor: Colors.white70,
          currentIndex: bloc.current,
          onTap: (int index) {
            bloc.changeIndex(index, context);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 26,
              ),
              activeIcon: Icon(
                Icons.home,
                size: 28,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_outlined,
                size: 26,
              ),
              activeIcon: Icon(
                Icons.chat,
                size: 28,
              ),
              label: 'chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_photo_alternate_outlined,
                size: 28,
                color: social4,
              ),
              activeIcon: Icon(
                Icons.add_circle,
                size: 36,
                color: social4,
              ),
              label: 'add post',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_outlined,
                size: 26,
              ),
              activeIcon: Icon(
                Icons.camera_rounded,
                size: 28,
              ),
              label: 'users',
            ),
            BottomNavigationBarItem(
              icon: ConditionalBuilderRec(
                condition: bloc.model != null,
                builder: (context) => CircleAvatar(
                  radius: 11,
                  backgroundImage: NetworkImage(bloc.model!.image),
                ),
                fallback: (context) => Icon(
                  Icons.person_outline,
                  size: 26,
                ),
              ),
              activeIcon: ConditionalBuilderRec(
                condition: bloc.model != null,
                builder: (context) => CircleAvatar(
                  radius: 14,
                  backgroundColor: social4,
                  child: CircleAvatar(
                    radius: 12,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundImage: NetworkImage(bloc.model!.image),
                    ),
                  ),
                ),
                fallback: (context) => Icon(
                  Icons.person_outline,
                  size: 26,
                ),
              ),
              label: 'profile',
            ),
          ],
        ),
      ),
    );
  }
}
