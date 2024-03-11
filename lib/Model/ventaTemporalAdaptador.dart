import 'package:hive_flutter/adapters.dart';
import 'package:tests/Model/ventaTemporal.dart';

class VentaTemporalAdapter extends TypeAdapter<VentaTemporal> {
  @override
  VentaTemporal fromMap(String key, Map<String, dynamic> json) {
    return VentaTemporal(
      producto: json['producto'],
      cantidad: json['cantidad'],
      fecha: DateTime.parse(json['fecha']),
    );
  }

  @override
  Map<String, dynamic> toMap(String key, VentaTemporal ventaTemporal) {
    return {
      'producto': ventaTemporal.producto,
      'cantidad': ventaTemporal.cantidad,
      'fecha': ventaTemporal.fecha.toIso8601String(),
    };
  }

  @override
  VentaTemporal read(BinaryReader reader) {
    final producto = reader.readString();
    final cantidad = reader.readInt();
    final fecha = DateTime.parse(reader.readString());

    return VentaTemporal(
      producto: producto,
      cantidad: cantidad,
      fecha: fecha,
    );
  }

  @override
  int get typeId => 1; // Unique type ID for VentaTemporal

  @override
  void write(BinaryWriter writer, VentaTemporal obj) {
    writer.writeString(obj.producto);
    writer.writeInt(obj.cantidad);
    writer.writeString(obj.fecha.toIso8601String());
  }
}
