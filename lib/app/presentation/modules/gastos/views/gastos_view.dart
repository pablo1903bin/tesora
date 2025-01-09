import 'package:flutter/material.dart';

class GastosView extends StatelessWidget {
  const GastosView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
      List<dynamic> gastos = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Gastos'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: gastos.isEmpty
          ? const Center(
              child: Text(
                'No hay gastos registrados',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: gastos.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.money_off,
                      color: Colors.red,
                    ),
                    title: Text(
                      gastos[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                    onTap: () {
                      // Acción al pulsar un gasto
                      print('Gasto seleccionado: ${gastos[index]}');
                    },
                  ),
                );
              },
            ),
    );
  }
}
