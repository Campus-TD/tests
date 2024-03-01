import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tests/Widgets/buildMenu.dart';

class IniciarSesionView extends StatelessWidget {
  const IniciarSesionView({Key? key}) : super(key: key);
  @override
  Widget build(
    BuildContext context,
  ) {
    return SideMenu(
        background: Colors.grey,
        menu: const SideMenuContent(),
        type: SideMenuType.slide,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Iniciar Sesión'),
          ),
          body: const Center(
            child: Text(''),
          ),
        ));
  }
}
