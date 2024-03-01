class Producto {
  String codigoBarras;
  String nombre;
  String categoria;
  String descripcion;
  String medida;
  double costo;
  double precioMenudeo;
  double precioMayoreo;
  int cantidadMinimaMayoreo;
  int cantidad;
  int cantidadSeleccionada = 0;
  Producto({
    required this.codigoBarras,
    required this.nombre,
    required this.categoria,
    required this.descripcion,
    required this.medida,
    required this.costo,
    required this.precioMenudeo,
    required this.precioMayoreo,
    required this.cantidadMinimaMayoreo,
    required this.cantidad,
  });
  String get getCodigoBarras => codigoBarras;
  set setCodigoBarras(String codigoBarras) => this.codigoBarras = codigoBarras;

  String get getNombre => nombre;
  set setNombre(String nombre) => this.nombre = nombre;

  String get getCategoria => categoria;
  set setCategoria(String categoria) => this.categoria = categoria;

  String get getDescripcion => descripcion;
  set setDescripcion(String descripcion) => this.descripcion = descripcion;

  String get getMedida => medida;
  set setMedida(String medida) => this.medida = medida;

  double get getCosto => costo;
  set setCosto(double costo) => this.costo = costo;

  double get getPrecioMenudeo => precioMenudeo;
  set setPrecioMenudeo(double precioMenudeo) =>
      this.precioMenudeo = precioMenudeo;

  double get getPrecioMayoreo => precioMayoreo;
  set setPrecioMayoreo(double precioMayoreo) =>
      this.precioMayoreo = precioMayoreo;

  int get getCantidadMinimaMayoreo => cantidadMinimaMayoreo;
  set setCantidadMinimaMayoreo(int cantidadMinimaMayoreo) =>
      this.cantidadMinimaMayoreo = cantidadMinimaMayoreo;

  int get getCantidad => cantidad;
  set setCantidad(int cantidad) => this.cantidad = cantidad;
}
