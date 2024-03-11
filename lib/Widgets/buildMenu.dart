import 'package:flutter/material.dart';
import 'package:tests/View/configuracion.dart';
import 'package:tests/View/iniciarSesion.dart';
import 'package:tests/View/inventario.dart';
import 'package:tests/View/inicio.dart';
import 'package:tests/View/reportes.dart';
import 'package:tests/View/usuarios.dart';
import 'package:tests/View/ventas.dart';

class SideMenuContent extends StatelessWidget {
  const SideMenuContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 50),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PrincipalView(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Venta'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const VentasView(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.inventory),
          title: const Text('Inventario'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const InventarioView(),
              ),
            );
          },
        ),
        const SizedBox(height: 425),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Cerrar Aplicación'),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        /* ListTile(
          leading: const Icon(Icons.receipt),
          title: const Text('Reportes'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ReportesView(),
              ),
            );
          },
        ),
        
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Usuarios'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => UsuariosView(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configuración'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ConfiguracionView(),
              ),
            );
          },
        ),
        const SizedBox(height: 25),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar Sesión'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const IniciarSesionView(),
              ),
            );
          },
        ),*/
      ],
    );
  }
}
