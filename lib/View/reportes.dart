/*import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tests/Widgets/appBar.dart';
import 'package:tests/Widgets/buildMenu.dart';
import 'package:tests/Controller/cVentas.dart';
import 'package:tests/Model/producto.dart';

class ReportesView extends StatefulWidget {
  const ReportesView({super.key});

  @override
  _ReportesViewState createState() => _ReportesViewState();
}

class _ReportesViewState extends State<ReportesView> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  final CVentas cVentas = CVentas();
  int posicionVenta = 1; // Variable para rastrear la posición de la venta

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Colors.grey,
      key: sideMenuKey,
      menu: const SideMenuContent(),
      type: SideMenuType.slide,
      child: Scaffold(
        appBar: getAppBar('Reportes', sideMenuKey),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Retroceder en la posición de la venta
                      setState(() {
                        posicionVenta++;
                      });
                    },
                  ),
                  Text(
                    'Fecha: ${cVentas.getVentaPorPosicion(posicionVenta).}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Avanzar en la posición de la venta
                      if (posicionVenta > 1) {
                        setState(() {
                          posicionVenta--;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Costo')),
                  DataColumn(label: Text('Cantidad')),
                ],
                rows: _buildProductRows(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildProductRows() {
    // Obtener la lista de productos de la venta actual
    Future<List<Producto>> ventaActual =
        cVentas.getVentaPorPosicion(posicionVenta).ge;

    return ventaActual..map((producto) {
      return DataRow(
        cells: [
          DataCell(Text(producto.nombre)),
          DataCell(Text('${producto.costo}')),
          DataCell(Text('${producto.cantidad}')),
        ],
      );
    }).toList();
  }
}*/
