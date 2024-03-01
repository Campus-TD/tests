// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tests/Controller/cVentasTemp.dart';
import 'package:tests/Model/producto.dart';
import 'package:tests/Widgets/appBar.dart';
import 'package:tests/Widgets/buildMenu.dart';

class VentasView extends StatefulWidget {
  const VentasView({super.key});

  @override
  _VentasViewState createState() => _VentasViewState();
}

class _VentasViewState extends State<VentasView> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  final CVentas cVentas = CVentas();
  late Future<List<Producto>> productos;
  late Future<List<Producto>> tempSaleList;

  OverlayEntry? overlayEntry;

  final GlobalKey texFieldPosition = GlobalKey();
  double total = 0.0;
  @override
  void initState() {
    super.initState();
    productos = cVentas.getTempSaleList();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Colors.grey,
      key: sideMenuKey,
      menu: const SideMenuContent(),
      type: SideMenuType.slide,
      child: Scaffold(
        appBar: getAppBar('Venta', sideMenuKey),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 197, 225),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fixedSize: const Size(69, 50),
                  ),
                  onPressed: () {
                    // Agregar lógica para el escáner de código QR
                  },
                  child: const Icon(
                    Icons.qr_code_scanner_outlined,
                    color: Colors.black,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    key: texFieldPosition,
                    child: TextField(
                      onSubmitted: (value) async {
                        tempSaleList =
                            cVentas.filterProductsByNameOrBarcode(value);
                        showPopupMenu(context, tempSaleList);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        labelText: 'Buscar producto',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 197, 225),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    fixedSize: const Size(174, 55),
                  ),
                  onPressed: () async {
                    final List<Producto> tempSaleList =
                        await cVentas.getTempSaleList();
                    cVentas.saveVenta(tempSaleList);
                    cVentas.clearTempSaleProducts();
                  },
                  child: const Text('Finalizar venta',
                      style: TextStyle(fontSize: 17, color: Colors.black87)),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 197, 225),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fixedSize: const Size(80, 55),
                  ),
                  onPressed: () async {
                    await cVentas
                        .resetCantidadSeleccionada(cVentas.getTempSaleList());
                    await cVentas.clearTempSaleProducts();
                    setState(() {
                      productos = cVentas.getTempSaleList();
                    });
                  },
                  child: const Icon(
                    Icons.replay_outlined,
                    color: Colors.black,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 197, 225),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fixedSize: const Size(80, 55),
                  ),
                  onPressed: () {
                    // Agregar lógica para realizar pago
                  },
                  child: const Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.black,
                    size: 23,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FutureBuilder<List<Producto>>(
                      future: productos,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text(
                              'No hay productos en la venta temporal.');
                        } else {
                          return Column(
                            children: [
                              for (var producto in snapshot.data!)
                                ListTile(
                                  title: Text(producto.nombre),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Precio: ${producto.costo}'),
                                      Text(
                                          'Cantidad Disponible: ${producto.cantidad}'),
                                      Row(
                                        children: [
                                          Text(
                                              'Cantidad Seleccionada: ${producto.cantidadSeleccionada}'),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                cVentas
                                                    .updateCantidadSeleccionada(
                                                        producto, 1);
                                                productos =
                                                    cVentas.getTempSaleList();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      cVentas.removeTempSaleProduct(producto);
                                      cVentas.updateCantidadDeseleccionada(
                                          producto,
                                          producto.cantidadSeleccionada);
                                      setState(() {
                                        productos = cVentas.getTempSaleList();
                                      });
                                    },
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total de la Venta:'),
                                    Text(
                                      cVentas
                                          .calculateTotal(snapshot.data!)
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showPopupMenu(
      BuildContext context, Future<List<Producto>> tempSaleList) async {
    final List<Producto> productosList = await tempSaleList;

    if (productosList.isNotEmpty) {
      // Crear una entrada de Overlay para mantener el foco en el TextField
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: 0,
          top: 0,
          width: 0,
          height: 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Al tocar el overlay, oculta el menú emergente
                overlayEntry?.remove();
                overlayEntry = null;
              },
              child: Container(),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(overlayEntry!);

      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          110,
          170,
          MediaQuery.of(texFieldPosition.currentContext!).size.width,
          0,
        ),
        items: productosList.map((producto) {
          return PopupMenuItem(
            child: ListTile(
              title: Text(producto.nombre),
              subtitle: Text(
                'Costo: ${producto.costo} - Cantidad: ${producto.cantidad}',
              ),
              onTap: () async {
                await cVentas.verifyProductInBox(producto, 1, context);
                setState(() {
                  productos = cVentas.getTempSaleList();
                });
                overlayEntry?.remove();
                overlayEntry = null;
              },
            ),
          );
        }).toList(),
      );
    }
  }
}
