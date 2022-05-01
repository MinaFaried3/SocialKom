import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialkom/models/drawerModel.dart';

class MenuItems {
  static final home = MenuItem(title: 'Home', icon: FontAwesomeIcons.house);
  static final explore = MenuItem(title: 'Explore', icon: Icons.explore);
  static final notification =
      MenuItem(title: 'Notifications', icon: Icons.notifications_active);
  static final chats =
      MenuItem(title: 'Chats', icon: FontAwesomeIcons.solidMessage);
  static final profile =
      MenuItem(title: 'Profile', icon: FontAwesomeIcons.userLarge);
  static final settings = MenuItem(title: 'Settings', icon: Icons.settings);

  static final addPost =
      MenuItem(title: 'Add Post', icon: Icons.add_photo_alternate_outlined);
  static final stories =
      MenuItem(title: 'Stories', icon: FontAwesomeIcons.stopwatch);
  static final save = MenuItem(title: 'Saved Posts', icon: Icons.turned_in);

  static List<MenuItem> all = [
    home,
    profile,
    chats,
    notification,
    save,
    stories,
    explore,
    settings,
  ];
}
