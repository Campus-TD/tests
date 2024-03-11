import 'package:hive/hive.dart';
import 'package:tests/Model/producto.dart';
import 'package:tests/Model/venta.dart';

class VentaAdapter extends TypeAdapter<Venta> {
  @override
  Venta read(BinaryReader reader) {
    final productosLength = reader.readByte();
    final productos = <Producto>[];

    for (var i = 0; i < productosLength; i++) {
      final producto = reader.read();
      productos.add(producto);
    }

    return Venta()..productos = productos;
  }

  @override
  void write(BinaryWriter writer, Venta obj) {
    writer.writeByte(obj.productos.length);
    for (var producto in obj.productos) {
      writer.write(producto);
    }
  }

  @override
  int get typeId => 2; // Unique type ID for Venta
}
