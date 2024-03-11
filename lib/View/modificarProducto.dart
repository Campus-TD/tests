import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:tests/Controller/cModificarPorductos.dart';
import 'package:tests/Model/producto.dart';
import 'package:tests/View/inventario.dart';
import 'package:tests/Widgets/appBar.dart';
import 'package:tests/Widgets/buildMenu.dart';

class ModificarProductoView extends StatefulWidget {
  final Producto producto;
  const ModificarProductoView({super.key, required this.producto});

  @override
  _ModificarProductoViewState createState() => _ModificarProductoViewState();
}

class _ModificarProductoViewState extends State<ModificarProductoView> {
  final CModificarProductos cModificarProductos = CModificarProductos();
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  late String codigodebarrass;
  late TextEditingController nombreController;
  late TextEditingController categoriaController;
  late TextEditingController costoController;
  late TextEditingController cantidadController;
  late TextEditingController descripcionController;
  late TextEditingController medidaController;
  late TextEditingController precioMenudeoController;
  late TextEditingController precioMayoreoController;
  late TextEditingController cantidadMinimaMayoreoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.producto.nombre);
    categoriaController =
        TextEditingController(text: widget.producto.categoria);
    costoController =
        TextEditingController(text: widget.producto.costo.toString());
    cantidadController =
        TextEditingController(text: widget.producto.cantidad.toString());
    descripcionController =
        TextEditingController(text: widget.producto.descripcion);
    medidaController = TextEditingController(text: widget.producto.medida);
    precioMenudeoController =
        TextEditingController(text: widget.producto.precioMenudeo.toString());
    precioMayoreoController =
        TextEditingController(text: widget.producto.precioMayoreo.toString());
    cantidadMinimaMayoreoController = TextEditingController(
        text: widget.producto.cantidadMinimaMayoreo.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Colors.grey,
      key: sideMenuKey,
      menu: const SideMenuContent(),
      type: SideMenuType.slide,
      child: Scaffold(
        appBar: getAppBar('Modificar Producto', sideMenuKey),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                controller: nombreController,
                onChanged: (value) {
                  nombreController.text = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Nombre del producto',
                ),
              ),
              TextField(
                controller: categoriaController,
                onChanged: (value) {
                  categoriaController.text = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                ),
              ),
              TextField(
                controller: costoController,
                onChanged: (value) {
                  costoController.text = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                ),
              ),
              TextField(
                controller: cantidadController,
                onChanged: (value) {
                  cantidadController.text = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                ),
              ),
              TextField(
                controller: descripcionController,
                onChanged: (value) {
                  descripcionController.text = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                ),
              ),
              TextField(
                controller: medidaController,
                onChanged: (value) {
                  medidaController.text = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Unidad de Medida',
                ),
              ),
              TextField(
                controller: precioMenudeoController,
                onChanged: (value) {
                  precioMenudeoController.text = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Precio de Menudeo',
                ),
              ),
              TextField(
                controller: precioMayoreoController,
                onChanged: (value) {
                  precioMayoreoController.text = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Precio de Mayoreo',
                ),
              ),
              TextField(
                controller: cantidadMinimaMayoreoController,
                onChanged: (value) {
                  cantidadMinimaMayoreoController.text = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad Mínima para Mayoreo',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  cModificarProductos.updateProduct(
                    Producto(
                      codigoBarras: widget.producto.codigoBarras,
                      nombre: nombreController.text,
                      categoria: categoriaController.text,
                      costo: double.parse(costoController.text),
                      cantidad: int.parse(cantidadController.text),
                      descripcion: descripcionController.text,
                      medida: medidaController.text,
                      precioMenudeo: double.parse(precioMenudeoController.text),
                      precioMayoreo: double.parse(precioMayoreoController.text),
                      cantidadMinimaMayoreo:
                          int.parse(cantidadMinimaMayoreoController.text),
                    ),
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InventarioView()));
                },
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
