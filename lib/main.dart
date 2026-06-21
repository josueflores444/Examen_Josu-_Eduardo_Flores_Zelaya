//Josué Eduardo Flores Zelaya 0703200503430
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistroVehiculos(),
    );
  }
}

class RegistroVehiculos extends StatefulWidget {
  const RegistroVehiculos({super.key});

  @override
  State<RegistroVehiculos> createState() => _RegistroVehiculosState();
}

class _RegistroVehiculosState extends State<RegistroVehiculos> {
  final txtPlaca = TextEditingController();
  final txtMarca = TextEditingController();
  final txtModelo = TextEditingController();
  final txtAnio = TextEditingController();

  List<Map<String, String>> vehiculos = [];

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void registrarVehiculo() {
    String placa = txtPlaca.text.trim();
    String marca = txtMarca.text.trim();
    String modelo = txtModelo.text.trim();
    String anio = txtAnio.text.trim();

    if (placa.isEmpty || marca.isEmpty || modelo.isEmpty || anio.isEmpty) {
      mostrarMensaje("Error: Todos los campos son obligatorios.");
      return;
    }

    if (int.tryParse(anio) == null) {
      mostrarMensaje(
        "Error: El año debe contener únicamente valores numéricos.",
      );
      return;
    }

    bool placaExiste = vehiculos.any(
      (v) => v["placa"]!.toLowerCase() == placa.toLowerCase(),
    );
    if (placaExiste) {
      mostrarMensaje(
        "Error: Ya existe un vehículo registrado con la placa $placa.",
      );
      return;
    }

    setState(() {
      vehiculos.add({
        "placa": placa,
        "marca": marca,
        "modelo": modelo,
        "anio": anio,
      });
    });

    txtPlaca.clear();
    txtMarca.clear();
    txtModelo.clear();
    txtAnio.clear();

    mostrarMensaje("Vehículo registrado exitosamente.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Vehículos"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: txtPlaca,
              decoration: const InputDecoration(labelText: "Placa"),
            ),
            TextField(
              controller: txtMarca,
              decoration: const InputDecoration(labelText: "Marca"),
            ),
            TextField(
              controller: txtModelo,
              decoration: const InputDecoration(labelText: "Modelo"),
            ),
            TextField(
              controller: txtAnio,
              decoration: const InputDecoration(labelText: "Año"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registrarVehiculo,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Registrar Vehículo"),
            ),
            const SizedBox(height: 25),
            const Text(
              "Vehículos Registrados",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Placa")),
                      DataColumn(label: Text("Marca")),
                      DataColumn(label: Text("Modelo")),
                      DataColumn(label: Text("Año")),
                    ],
                    rows: vehiculos.map((vehiculo) {
                      return DataRow(
                        cells: [
                          DataCell(Text(vehiculo["placa"]!)),
                          DataCell(Text(vehiculo["marca"]!)),
                          DataCell(Text(vehiculo["modelo"]!)),
                          DataCell(Text(vehiculo["anio"]!)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
