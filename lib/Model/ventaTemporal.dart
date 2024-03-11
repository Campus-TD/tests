class VentaTemporal {
  String producto;
  int cantidad;
  DateTime fecha;

  VentaTemporal({
    required this.producto,
    required this.cantidad,
    required this.fecha,
  });

  String get getProducto => producto;
  set setProducto(String producto) => this.producto = producto;

  int get getCantidad => cantidad;
  set setCantidad(int cantidad) => this.cantidad = cantidad;

  DateTime get getFecha => fecha;
  set setFecha(DateTime fecha) => this.fecha = fecha;
}
