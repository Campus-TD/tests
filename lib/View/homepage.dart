import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tests/View/inicio.dart';
import 'package:tests/Widgets/buildMenu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Colors.grey,
      key: sideMenuKey,
      menu: const SideMenuContent(),
      type: SideMenuType.slide,
      child: Scaffold(
        body: PrincipalView(),
      ),
    );
  }
}
