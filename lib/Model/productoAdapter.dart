import 'package:hive_flutter/adapters.dart';
import 'package:tests/Model/producto.dart';

class ProductoAdapter extends TypeAdapter<Producto> {
  @override
  Producto fromMap(String key, Map<String, dynamic> json) {
    return Producto(
      codigoBarras: json['codigoBarras'],
      nombre: json['nombre'],
      categoria: json['categoria'],
      descripcion: json['descripcion'],
      medida: json['medida'],
      costo: json['costo'],
      precioMenudeo: json['precioMenudeo'],
      precioMayoreo: json['precioMayoreo'],
      cantidadMinimaMayoreo: json['cantidadMinimaMayoreo'],
      cantidad: json['cantidad'],
    );
  }

  @override
  Map<String, dynamic> toMap(String key, Producto producto) {
    return {
      'codigoBarras': producto.codigoBarras,
      'nombre': producto.nombre,
      'categoria': producto.categoria,
      'descripcion': producto.descripcion,
      'medida': producto.medida,
      'costo': producto.costo,
      'precioMenudeo': producto.precioMenudeo,
      'precioMayoreo': producto.precioMayoreo,
      'cantidadMinimaMayoreo': producto.cantidadMinimaMayoreo,
      'cantidad': producto.cantidad,
    };
  }

  @override
  Producto read(BinaryReader reader) {
    final codigoBarras = reader.readString();
    final nombre = reader.readString();
    final categoria = reader.readString();
    final descripcion = reader.readString();
    final medida = reader.readString();
    final costo = reader.readDouble();
    final precioMenudeo = reader.readDouble();
    final precioMayoreo = reader.readDouble();
    final cantidadMinimaMayoreo = reader.readInt();
    final cantidad = reader.readInt();

    return Producto(
      codigoBarras: codigoBarras,
      nombre: nombre,
      categoria: categoria,
      descripcion: descripcion,
      medida: medida,
      costo: costo,
      precioMenudeo: precioMenudeo,
      precioMayoreo: precioMayoreo,
      cantidadMinimaMayoreo: cantidadMinimaMayoreo,
      cantidad: cantidad,
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Producto obj) {
    writer.writeString(obj.codigoBarras);
    writer.writeString(obj.nombre);
    writer.writeString(obj.categoria);
    writer.writeString(obj.descripcion);
    writer.writeString(obj.medida);
    writer.writeDouble(obj.costo);
    writer.writeDouble(obj.precioMenudeo);
    writer.writeDouble(obj.precioMayoreo);
    writer.writeInt(obj.cantidadMinimaMayoreo);
    writer.writeInt(obj.cantidad);
  }
}
