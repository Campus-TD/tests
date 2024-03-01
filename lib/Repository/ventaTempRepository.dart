import 'package:hive_flutter/hive_flutter.dart';
import 'package:tests/Model/producto.dart';
import 'package:tests/Model/venta.dart';

class VentaTempRepository {
  final Box _ventaTempBox = Hive.box('ventaTemporal');
  final Box _ventasBox = Hive.box('ventas');
  final Box _productosBox = Hive.box('productos');

  Future<List<Producto>> getTempVentaProducts() async {
    return _ventaTempBox.values.cast<Producto>().toList();
  }

  Future<void> addTempVentaProduct(Producto producto) async {
    await _ventaTempBox.add(producto);
  }

  Future<void> removeTempVentaProduct(Producto producto) async {
    await _ventaTempBox
        .deleteAt(_ventaTempBox.values.toList().indexOf(producto));
  }

  Future<void> clearTempVentaProducts() async {
    await _ventaTempBox.clear();
  }

  Future<void> saveVenta(List<Producto> productos) async {
    await _ventasBox.add(productos);
  }

  Future<List<Producto>> getProducts() async {
    return _productosBox.values.cast<Producto>().toList();
  }

  Future<bool> isProductInBox(Producto producto) async {
    return _ventaTempBox.values.contains(producto);
  }

  Future<void> updateCantidadSeleccionada(
      Producto producto, int cantidad) async {
    final index = _ventaTempBox.values.toList().indexOf(producto);
    if (index != -1) {
      producto.cantidadSeleccionada += cantidad;
      producto.cantidad -= cantidad; // Resta la cantidad añadida
      await _ventaTempBox.putAt(index, producto);
    }
  }

  Future<void> updateCantidadDeseleccionada(
      Producto producto, int cantidad) async {
    final index = _ventaTempBox.values.toList().indexOf(producto);
    if (index != -1) {
      producto.cantidadSeleccionada -= cantidad;
      producto.cantidad += cantidad; // Suma la cantidad restada
      await _ventaTempBox.putAt(index, producto);
    }
  }

  Future<void> resetCantidadSeleccionada(
      Future<List<Producto>> productos) async {
    var productosList = await productos;
    for (var producto in productosList) {
      final index = _ventaTempBox.values.toList().indexOf(producto);
      if (index != -1) {
        producto.cantidad +=
            producto.cantidadSeleccionada; // Suma la cantidad deseleccionada
        producto.cantidadSeleccionada = 0; // Reinicia la cantidad seleccionada
        await _productosBox.putAt(
            index, producto); // Actualiza el producto en el box de productos
      }
    }
  }

  Future<void> updateProductosCantidades(
      Future<List<Producto>> productos) async {
    var productosList = await productos;
    for (var producto in productosList) {
      final index = _productosBox.values.toList().indexOf(producto);
      if (index != -1) {
        producto.cantidad +=
            producto.cantidadSeleccionada; // Suma la cantidad deseleccionada
        producto.cantidadSeleccionada = 0; // Reinicia la cantidad seleccionada
        await _productosBox.putAt(
            index, producto); // Actualiza el producto en el box de productos
      }
    }
  }

  Future<Venta> getVentaPorPosicion(int numero) async {
    return await _ventasBox.getAt(_ventasBox.length - numero);
  }
}
