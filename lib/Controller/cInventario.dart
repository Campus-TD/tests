import 'package:tests/Model/producto.dart';
import 'package:tests/Repository/inventoryRepository.dart';
import 'package:tests/Services/inventoryService.dart';

class CInventario {
  InventoryService inventarioService = InventoryService(InventoryRepository());
  void addCategory(String categoryName) {
    inventarioService.repository.addCategory(categoryName);
  }

  Future<List<String>> getCategories() async {
    return inventarioService.repository.getCategories();
  }

  void addProduct(Producto producto) {
    inventarioService.repository.addProduct(producto);
  }

  Future<List<Producto>> getProducts() async {
    return inventarioService.getProducts();
  }

  //ordenamientos
  Future<List<Producto>> sortProductsByCost(bool isDescending) async {
    return inventarioService.sortProductsByCost(isDescending);
  }

  Future<List<Producto>> sortProductsByQuantity(bool isDescending) async {
    return inventarioService.sortProductsByQuantity(isDescending);
  }

  //filtros
  Future<List<Producto>> filterProductsByCategory(int categoryPosition) async {
    return inventarioService.filterProductsByCategory(categoryPosition);
  }

  Future<List<Producto>> filterProductsByName(String name) async {
    return inventarioService.filterProductsByName(name);
  }

  Future<List<Producto>> filterProductsByNameOrBarcode(String query) async {
    return inventarioService.filterProductsByNameOrBarcode(query);
  }

  //verificaciones
  validacionProducto(Producto producto) {
    return inventarioService.areFieldsNotEmpty(producto);
  }
}
