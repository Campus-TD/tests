import 'package:tests/Model/producto.dart';
import 'package:tests/Repository/ventaTempRepository.dart';
import 'package:tests/Services/ventasService.dart';

class CVentas {
  late VentasService ventasService = VentasService(VentaTempRepository());

  CVentas() {
    ventasService = VentasService(VentaTempRepository());
  }
  Future<List<Producto>> getTempSaleList() async {
    return ventasService.getTempSaleList();
  }

  Future<void> addTempSaleProduct(Producto producto) async {
    return ventasService.addTempSaleProduct(producto);
  }

  Future<void> removeTempSaleProduct(Producto producto) async {
    return ventasService.removeTempSaleProduct(producto);
  }

  Future<void> clearTempSaleProducts() async {
    return ventasService.clearTempSaleProducts();
  }

  Future<void> saveVenta(List<Producto> productos) async {
    return ventasService.saveVenta(productos);
  }

  Future<List<Producto>> filterProductsByName(String name) async {
    return ventasService.filterProductsByName(name);
  }

  Future<List<Producto>> filterProductsByNameOrBarcode(String query) async {
    return ventasService.filterProductsByNameOrBarcode(query);
  }

  double calculateTotal(List<Producto> productos) {
    double total = 0.0;
    for (var producto in productos) {
      total += producto.costo * producto.cantidadSeleccionada;
    }
    return total;
  }

  Future<void> verifyProductInBox(
      Producto producto, int cantidad, context) async {
    bool isInBox = await ventasService.isProductInBox(producto);
    if (isInBox) {
      await ventasService.updateCantidadSeleccionada(producto, cantidad);
    } else {
      await addTempSaleProduct(producto);
      updateCantidadSeleccionada(producto, cantidad);
    }
  }

  Future<void> updateCantidadDeseleccionada(
      Producto producto, int cantidad) async {
    ventasService.updateCantidadDeseleccionada(producto, cantidad);
  }

  Future<void> updateCantidadSeleccionada(
      Producto producto, int cantidad) async {
    ventasService.updateCantidadSeleccionada(producto, cantidad);
  }

  Future<void> resetCantidadSeleccionada(
      Future<List<Producto>> productos) async {
    ventasService.resetCantidadSeleccionada(productos);
  }

  Future<void> updateProductosCantidades(
      Future<List<Producto>> productos) async {
    ventasService.updateProductosCantidades(productos);
  }
}
