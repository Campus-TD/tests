import 'package:tests/Model/producto.dart';
import 'package:tests/Repository/inventoryRepository.dart';

class InventoryService {
  final InventoryRepository repository;
  InventoryService(this.repository);

  void addCategory(String categoryName) {
    repository.addCategory(categoryName);
  }

  Future<List<String>> getCategories() async {
    return repository.getCategories();
  }

  void addProduct(Producto producto) {
    repository.addProduct(producto);
  }

  Future<List<Producto>> getProducts() async {
    return repository.getProducts();
  }

  Future<List<Producto>> filterProductsByCategory(int categoryPosition) async {
    List<Producto> products = await repository.getProducts();
    List<Producto> filteredProducts = products
        .where((producto) => producto.categoria == categoryPosition)
        .toList();
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

  Future<List<Producto>> filterProductsByName(String name) async {
    List<Producto> products = await repository.getProducts();
    List<Producto> filteredProducts =
        products.where((producto) => producto.nombre.contains(name)).toList();
    filteredProducts.sort(
        (a, b) => a.nombre.indexOf(name).compareTo(b.nombre.indexOf(name)));
    return filteredProducts;
  }

  Future<List<Producto>> sortProductsByCost(bool isDescending) async {
    List<Producto> products = await repository.getProducts();
    if (isDescending) {
      products.sort((a, b) => b.costo.compareTo(a.costo));
    } else {
      products.sort((a, b) => a.costo.compareTo(b.costo));
    }
    return products;
  }

  Future<List<Producto>> sortProductsByQuantity(bool isDescending) async {
    List<Producto> products = await repository.getProducts();
    if (isDescending) {
      products.sort((a, b) => b.costo.compareTo(a.cantidad));
    } else {
      products.sort((a, b) => a.costo.compareTo(b.cantidad));
    }
    return products;
  }

  bool areFieldsNotEmpty(Producto producto) {
    return producto.nombre != "" &&
        producto.categoria != "" &&
        producto.descripcion != "" &&
        producto.medida != "" &&
        producto.costo != 0.0 &&
        producto.precioMenudeo != 0.0 &&
        producto.precioMayoreo != 0.0 &&
        producto.cantidadMinimaMayoreo != 0 &&
        producto.cantidad != 0;
  }

  void deleteProduct(Producto producto) {
    repository.deleteProduct(producto);
  }

  void updateProduct(Producto producto) {
    repository.updateProduct(producto);
  }
}
