import 'package:hive_flutter/hive_flutter.dart';
import 'package:tests/Model/producto.dart';

class InventoryRepository {
  final Box _categoriasBox = Hive.box('categorias');
  final Box _productosBox = Hive.box('productos');
  Future<void> addCategory(String categoryName) async {
    await _categoriasBox.add(categoryName);
  }

  Future<void> addProduct(Producto producto) async {
    await _productosBox.add(producto);
  }

  Future<void> deleteProduct(Producto producto) async {
    await _productosBox
        .deleteAt(_productosBox.values.toList().indexOf(producto));
  }

  Future<List<Producto>> getProducts() async {
    return _productosBox.values.cast<Producto>().toList();
  }

  Future<List<String>> getCategories() async {
    return _categoriasBox.values.cast<String>().toList();
  }

  Future<void> deleteCategory(String categoryName) async {
    await _categoriasBox.delete(categoryName);
  }

  Future<void> updateProduct(Producto producto) async {
    int index = _productosBox.values
        .toList()
        .indexWhere((p) => p.codigoBarras == producto.codigoBarras);

    if (index != -1) {
      await _productosBox.putAt(index, producto);
    }
  }
}
