import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tests/View/inventario.dart';
import 'package:tests/View/reportes.dart';
import 'package:tests/View/ventas.dart';
import 'package:tests/Widgets/appBar.dart';
import 'package:tests/Widgets/buildMenu.dart';

class PrincipalView extends StatelessWidget {
  PrincipalView({super.key});

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Colors.grey,
      key: sideMenuKey,
      menu: const SideMenuContent(),
      type: SideMenuType.slide,
      child: Scaffold(
        appBar: getAppBar('Inicio', sideMenuKey),
        body: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 58),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 197, 225),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    fixedSize: const Size(135, 135),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const VentasView(),
                      ),
                    );
                  },
                  child: const Text(
                    "Venta",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 197, 225),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    fixedSize: const Size(135, 135),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const InventarioView(),
                      ),
                    );
                  },
                  child: const Text(
                    "Inventario",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            /*  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 58),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 197, 225),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    fixedSize: const Size(135, 135),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ReportesView(),
                      ),
                    );
                  },
                  child: const Text(
                    "Reportes",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
