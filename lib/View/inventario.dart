import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tests/Controller/cInventario.dart';
import 'package:tests/Model/producto.dart';
import 'package:tests/Widgets/appBar.dart';
import 'package:tests/Widgets/buildMenu.dart';
import 'package:tests/Widgets/productListWidget.dart';

enum SortType {
  none,
  byCostAsc,
  byCostDesc,
  byQuantityAsc,
  byQuantityDesc,
  byCategory,
  byText,
}

class InventarioView extends StatefulWidget {
  const InventarioView({super.key});
  @override
  _InventarioViewState createState() => _InventarioViewState();
}

class _InventarioViewState extends State<InventarioView> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  final CInventario cInventario = CInventario();
  final GlobalKey _buttonKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();

  SortType currentSortType = SortType.none;

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Colors.grey,
      key: sideMenuKey,
      menu: const SideMenuContent(),
      type: SideMenuType.slide,
      child: Scaffold(
        appBar: getAppBar('Inventario', sideMenuKey),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 25),
                ElevatedButton(
                  key: _buttonKey,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 180, 197, 225),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.18, 50),
                  ),
                  onPressed: () => showPopupMenu(context),
                  child: const Icon(
                    Icons.filter_list_rounded,
                    color: Colors.black,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.68,
                  height: 50,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (text) {
                      setState(() {
                        _searchController.text = text;
                        currentSortType = SortType.byText;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      labelText: 'Buscar producto',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ProductListWidget(
              productListFuture: _getSortedProducts(),
            ),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      child: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String codigoBarras = "";
              String nombre = "";
              String categoria = "";
              String descripcion = "";
              String medida = "";
              double costo = 0.0;
              double precioMenudeo = 0.0;
              double precioMayoreo = 0.0;
              int cantidadMinimaMayoreo = 0;
              int cantidad = 0;

              return AlertDialog(
                scrollable: true,
                title: const Text('Agregar Producto'),
                content: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextField(
                      onChanged: (value) {
                        nombre = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nombre del producto',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        categoria = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        costo = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        cantidad = int.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cantidad',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        descripcion = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Descripcion',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        medida = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Unidad de Medida',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        codigoBarras = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Codigo de Barras',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        precioMenudeo = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Precio de Menudeo',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        precioMayoreo = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Precio de Mayoreo',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        cantidadMinimaMayoreo = int.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cantidad Minima para Mayoreo',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Producto newProduct = Producto(
                        codigoBarras: codigoBarras,
                        nombre: nombre,
                        categoria: categoria,
                        descripcion: descripcion,
                        medida: medida,
                        costo: costo,
                        precioMenudeo: precioMenudeo,
                        precioMayoreo: precioMayoreo,
                        cantidadMinimaMayoreo: cantidadMinimaMayoreo,
                        cantidad: cantidad,
                      );
                      if (cInventario.validacionProducto(newProduct)) {
                        cInventario.addProduct(newProduct);
                        setState(() {
                          currentSortType = SortType.none;
                        });
                        Navigator.of(context).pop();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Campos Vacíos'),
                              content: const Text(
                                  'Por favor, complete todos los campos antes de agregar el producto.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Agregar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showPopupMenu(BuildContext context) {
    final RenderBox button =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu(
      context: context,
      position: position,
      items: [
        const PopupMenuItem<String>(
          value: 'pa',
          child: Row(
            children: [
              Text('Precio'),
              Expanded(child: SizedBox()),
              Icon(Icons.arrow_upward),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'pd',
          child: Row(
            children: [
              Text('Precio'),
              Expanded(child: SizedBox()),
              Icon(Icons.arrow_downward),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'ca',
          child: Row(
            children: [
              Text('Cantidad'),
              Expanded(child: SizedBox()),
              Icon(Icons.arrow_upward),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'cd',
          child: Row(
            children: [
              Text('Cantidad'),
              Expanded(child: SizedBox()),
              Icon(Icons.arrow_downward),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'categoria',
          child: Text('Categoria'),
        ),
      ],
    ).then((value) {
      if (value == "ca") {
        setState(() {
          currentSortType = SortType.byCostAsc;
        });
      }
      if (value == "cd") {
        setState(() {
          currentSortType = SortType.byCostDesc;
        });
      }
      if (value == "pa") {
        setState(() {
          currentSortType = SortType.byQuantityAsc;
        });
      }
      if (value == "pd") {
        setState(() {
          currentSortType = SortType.byQuantityDesc;
        });
      }
      if (value == "categoria") {
        setState(() {
          currentSortType = SortType.byCategory;
        });
      }
    });
  }

  Future<List<Producto>> _getSortedProducts() {
    switch (currentSortType) {
      case SortType.byText:
        return cInventario
            .filterProductsByNameOrBarcode(_searchController.text);
      case SortType.byCostAsc:
        return cInventario.sortProductsByCost(true);
      case SortType.byCostDesc:
        return cInventario.sortProductsByCost(false);
      case SortType.byQuantityAsc:
        return cInventario.sortProductsByQuantity(true);
      case SortType.byQuantityDesc:
        return cInventario.sortProductsByQuantity(false);
      case SortType.byCategory:
        return cInventario.filterProductsByCategory(1);
      case SortType.none:
      default:
        return cInventario.getProducts();
    }
  }
}
