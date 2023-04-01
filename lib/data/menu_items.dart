import 'package:flutter/material.dart';
import 'package:intern_flutter_challenge/models/menu_item.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [itemAbout];

  static const List<MenuItem> itemsSecond = [itemLogout];

  static const itemAbout = MenuItem(
    text: "About",
    icon: Icons.info,
  );

  static const itemLogout = MenuItem(
    text: "Logout",
    icon: Icons.logout,
  );
}
