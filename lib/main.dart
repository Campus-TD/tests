import 'package:flutter/material.dart';
import 'package:tests/Model/productoAdapter.dart';
import 'package:tests/Model/ventaAdaptador.dart';
import 'package:tests/Model/ventaTemporalAdaptador.dart';
import 'package:tests/Repository/ventaTempRepository.dart';
import 'package:tests/View/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductoAdapter());
  Hive.registerAdapter(VentaTemporalAdapter());
  Hive.registerAdapter(VentaAdapter());
  await Hive.openBox('categorias');
  await Hive.openBox('productos');
  await Hive.openBox('ventaTemporal');
  await Hive.openBox('ventas');
  VentaTempRepository ventaTempRepository = VentaTempRepository();
  await ventaTempRepository
      .resetCantidadSeleccionada(ventaTempRepository.getTempVentaProducts());
  Hive.box('ventaTemporal').clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Punto de Venta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
            secondary: Colors.orangeAccent,
            primary: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
