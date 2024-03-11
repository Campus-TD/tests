import 'package:tests/Model/producto.dart';

class Venta {
  List<Producto> productos = [];
  DateTime fecha = DateTime.now();
  Venta() {
    productos = [];
  }

  List<Producto> getProductos() {
    return productos;
  }

  DateTime getFecha() {
    return fecha;
  }
}
