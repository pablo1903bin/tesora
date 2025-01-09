import 'package:flutter/material.dart';

class CooperacionesView extends StatelessWidget {
  // Lista de cooperaciones de ejemplo
  final List<String> cooperaciones = [
    "Cooperación 1",
    "Cooperación 2",
    "Cooperación 3",
    "Cooperación 4",
    "Cooperación 5",
  ];

  CooperacionesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Cooperaciones"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: cooperaciones.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              leading: const Icon(Icons.group, color: Colors.blue),
              title: Text(cooperaciones[index],
                  style: const TextStyle(fontSize: 16.0)),
              subtitle: const Text("Detalles de la cooperación"),
              onTap: () {
                // Acción al tocar una cooperación
                print("Seleccionado: ${cooperaciones[index]}");
              },
            ),
          );
        },
      ),
    );
  }
}
