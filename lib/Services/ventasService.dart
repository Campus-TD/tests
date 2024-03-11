import 'package:flutter/gestures.dart';
import 'package:tests/Model/producto.dart';
import 'package:tests/Model/venta.dart';
import 'package:tests/Repository/ventaTempRepository.dart';

class VentasService {
  final VentaTempRepository repository;
  VentasService(this.repository);

  Future<List<Producto>> getTempSaleList() async {
    return repository.getTempVentaProducts();
  }

  Future<void> addTempSaleProduct(Producto producto) async {
    return repository.addTempVentaProduct(producto);
  }

  Future<void> removeTempSaleProduct(Producto producto) async {
    return repository.removeTempVentaProduct(producto);
  }

  Future<void> clearTempSaleProducts() async {
    return repository.clearTempVentaProducts();
  }

  Future<void> saveVenta(List<Producto> productos) async {
    return repository.saveVenta(productos);
  }

  Future<List<Producto>> filterProductsByName(String name) async {
    List<Producto> products = await repository.getProducts();
    List<Producto> filteredProducts =
        products.where((producto) => producto.nombre.contains(name)).toList();
    filteredProducts.sort(
        (a, b) => a.nombre.indexOf(name).compareTo(b.nombre.indexOf(name)));
    return filteredProducts;
  }

  Future<List<Producto>> filterProductsByNameOrBarcode(String query) async {
    List<Producto> products = await repository.getProducts();

    List<Producto> filteredProducts = products.where((producto) {
      return producto.nombre.contains(query) ||
          producto.codigoBarras.contains(query);
    }).toList();

    filteredProducts.sort((a, b) {
      return a.nombre.indexOf(query).compareTo(b.nombre.indexOf(query));
    });

    return filteredProducts;
  }

  Future<bool> isProductInBox(Producto producto) async {
    return repository.isProductInBox(producto);
  }

  Future<void> updateCantidadSeleccionada(
      Producto producto, int cantidad) async {
    repository.updateCantidadSeleccionada(producto, cantidad);
  }

  Future<void> updateCantidadDeseleccionada(
      Producto producto, int cantidad) async {
    repository.updateCantidadDeseleccionada(producto, cantidad);
  }

  Future<void> resetCantidadSeleccionada(
      Future<List<Producto>> productos) async {
    repository.resetCantidadSeleccionada(productos);
  }

  Future<void> updateProductosCantidades(
      Future<List<Producto>> productos) async {
    repository.updateProductosCantidades(productos);
  }

  Future<Venta> getLatestVentaList(int numero) async {
    return repository.getVentaPorPosicion(numero);
  }
}
