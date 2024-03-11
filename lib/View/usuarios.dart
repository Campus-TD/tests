import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tests/Widgets/appBar.dart';
import 'package:tests/Widgets/buildMenu.dart';

class UsuariosView extends StatelessWidget {
  UsuariosView({Key? key}) : super(key: key);
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  @override
  Widget build(
    BuildContext context,
  ) {
    return SideMenu(
        background: Colors.grey,
        key: sideMenuKey,
        menu: const SideMenuContent(),
        type: SideMenuType.slide,
        child: Scaffold(
          appBar: getAppBar('Usuarios', sideMenuKey),
          body: const Center(
            child: Text(''),
          ),
        ));
  }
}
