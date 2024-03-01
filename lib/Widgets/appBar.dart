import 'package:flutter/material.dart';

AppBar getAppBar(title, sideMenuKey) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        final state = sideMenuKey.currentState;
        if (state!.isOpened) {
          state.closeSideMenu();
        } else {
          state.openSideMenu();
        }
      },
    ),
    title: Text(title),
  );
}
