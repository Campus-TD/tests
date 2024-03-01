import 'package:flutter/material.dart';
import 'package:tests/Controller/cInventario.dart';
import 'package:tests/Model/producto.dart';
import 'package:tests/View/inventario.dart';
import 'package:tests/View/modificarProducto.dart';
import 'package:tests/View/ventas.dart';

class ProductListWidget extends StatelessWidget {
  late final Future<List<Producto>> productListFuture;

  final CInventario cInventario = CInventario();
  ProductListWidget({super.key, required this.productListFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Producto>>(
      future: productListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Producto> productList = snapshot.data!;
          double cellWidth = MediaQuery.of(context).size.width / 5;
          List<DataRow> rows = productList.map((producto) {
            return DataRow(
              color:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return Colors.blue.withOpacity(0.1);
              }),
              cells: [
                DataCell(
                  Container(
                      constraints: BoxConstraints(maxWidth: cellWidth),
                      child: showInfoName(context, producto)),
                ),
                DataCell(
                  Container(
                      constraints: BoxConstraints(maxWidth: cellWidth),
                      child: showInfoNameCategoria(context, producto)),
                ),
                DataCell(
                  Container(
                      constraints: BoxConstraints(maxWidth: cellWidth),
                      child: showInfoMedida(context, producto)),
                ),
                DataCell(
                  Container(
                      constraints: BoxConstraints(maxWidth: cellWidth),
                      child: showInfoCosto(context, producto)),
                ),
                DataCell(
                  Container(
                      constraints: BoxConstraints(maxWidth: cellWidth),
                      child: showInfoCantidad(context, producto)),
                ),
              ],
            );
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columnSpacing: 25,
              headingRowColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return Colors.blue.withOpacity(0.3);
              }),
              columns: const [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Categoría')),
                DataColumn(label: Text('Medida')),
                DataColumn(label: Text('Costo')),
                DataColumn(label: Text('Cantidad')),
              ],
              rows: rows,
            ),
          );
        }
      },
    );
  }

  InkWell showInfoName(BuildContext context, Producto producto) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Detalles del Producto'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Código de Barras: ${producto.codigoBarras}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Nombre: ${producto.nombre}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Categoría: ${producto.categoria}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Descripción: ${producto.descripcion}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Medida: ${producto.medida}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Costo: ${producto.costo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Menudeo: ${producto.precioMenudeo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Mayoreo: ${producto.precioMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Cantidad Mínima Mayoreo: ${producto.cantidadMinimaMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Cantidad: ${producto.cantidad}'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ModificarProductoView(producto: producto)),
                        );
                      },
                      child: const Text('Modificar Producto'),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Eliminar Producto'),
                              content: const Text(
                                  '¿Está seguro que desea eliminar el producto?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cInventario.inventarioService.repository
                                        .deleteProduct(producto);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InventarioView()));
                                  },
                                  child: const Text('Sí'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VentasView()),
                        );
                      },
                      child: const Text('Agregar a Venta Actual'),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Text(producto.nombre),
    );
  }

  InkWell showInfoNameCategoria(BuildContext context, Producto producto) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Detalles del Producto'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Código de Barras: ${producto.codigoBarras}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Nombre: ${producto.nombre}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Categoría: ${producto.categoria}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Descripción: ${producto.descripcion}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Medida: ${producto.medida}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Costo: ${producto.costo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Menudeo: ${producto.precioMenudeo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Mayoreo: ${producto.precioMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Cantidad Mínima Mayoreo: ${producto.cantidadMinimaMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Cantidad: ${producto.cantidad}'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ModificarProductoView(producto: producto)),
                        );
                      },
                      child: const Text('Modificar Producto'),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Eliminar Producto'),
                              content: const Text(
                                  '¿Está seguro que desea eliminar el producto?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cInventario.inventarioService.repository
                                        .deleteProduct(producto);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InventarioView()));
                                  },
                                  child: const Text('Sí'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VentasView()),
                        );
                      },
                      child: const Text('Agregar a Venta Actual'),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Text(producto.categoria),
    );
  }

  InkWell showInfoMedida(BuildContext context, Producto producto) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Detalles del Producto'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Código de Barras: ${producto.codigoBarras}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Nombre: ${producto.nombre}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Categoría: ${producto.categoria}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Descripción: ${producto.descripcion}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Medida: ${producto.medida}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Costo: ${producto.costo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Menudeo: ${producto.precioMenudeo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Mayoreo: ${producto.precioMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Cantidad Mínima Mayoreo: ${producto.cantidadMinimaMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Cantidad: ${producto.cantidad}'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ModificarProductoView(producto: producto)),
                        );
                      },
                      child: const Text('Modificar Producto'),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Eliminar Producto'),
                              content: const Text(
                                  '¿Está seguro que desea eliminar el producto?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cInventario.inventarioService.repository
                                        .deleteProduct(producto);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InventarioView()));
                                  },
                                  child: const Text('Sí'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VentasView()),
                        );
                      },
                      child: const Text('Agregar a Venta Actual'),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Text(producto.medida),
    );
  }

  InkWell showInfoCosto(BuildContext context, Producto producto) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Detalles del Producto'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Código de Barras: ${producto.codigoBarras}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Nombre: ${producto.nombre}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Categoría: ${producto.categoria}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Descripción: ${producto.descripcion}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Medida: ${producto.medida}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Costo: ${producto.costo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Menudeo: ${producto.precioMenudeo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Mayoreo: ${producto.precioMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Cantidad Mínima Mayoreo: ${producto.cantidadMinimaMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Cantidad: ${producto.cantidad}'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ModificarProductoView(producto: producto)),
                        );
                      },
                      child: const Text('Modificar Producto'),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Eliminar Producto'),
                              content: const Text(
                                  '¿Está seguro que desea eliminar el producto?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cInventario.inventarioService.repository
                                        .deleteProduct(producto);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InventarioView()));
                                  },
                                  child: const Text('Sí'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VentasView()),
                        );
                      },
                      child: const Text('Agregar a Venta Actual'),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Text(producto.costo.toString()),
    );
  }

  InkWell showInfoCantidad(BuildContext context, Producto producto) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Detalles del Producto'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Código de Barras: ${producto.codigoBarras}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Nombre: ${producto.nombre}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Categoría: ${producto.categoria}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Descripción: ${producto.descripcion}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Medida: ${producto.medida}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Costo: ${producto.costo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Menudeo: ${producto.precioMenudeo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Precio Mayoreo: ${producto.precioMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Cantidad Mínima Mayoreo: ${producto.cantidadMinimaMayoreo}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Cantidad: ${producto.cantidad}'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ModificarProductoView(producto: producto)),
                        );
                      },
                      child: const Text('Modificar Producto'),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Eliminar Producto'),
                              content: const Text(
                                  '¿Está seguro que desea eliminar el producto?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cInventario.inventarioService.repository
                                        .deleteProduct(producto);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InventarioView()));
                                  },
                                  child: const Text('Sí'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VentasView()),
                        );
                      },
                      child: const Text('Agregar a Venta Actual'),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Text(producto.cantidad.toString()),
    );
  }
}
