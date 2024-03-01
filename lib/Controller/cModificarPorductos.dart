import 'package:tests/Model/producto.dart';
import 'package:tests/Repository/inventoryRepository.dart';
import 'package:tests/Services/inventoryService.dart';

class CModificarProductos {
  late InventoryService inventoryService;

  CModificarProductos() {
    inventoryService = InventoryService(InventoryRepository());
  }

  void addCategory(String categoryName) {
    inventoryService.addCategory(categoryName);
  }

  Future<List<String>> getCategories() async {
    return inventoryService.getCategories();
  }

  void updateProduct(Producto producto) {
    inventoryService.updateProduct(producto);
  }
}
