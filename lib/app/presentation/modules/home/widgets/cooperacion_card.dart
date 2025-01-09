import 'package:flutter/material.dart';

class CooperacionCard extends StatelessWidget {
  final String? nombre;
  final String? descripcion;
  final String? estado;
  final double montoObjetivo;
  final double montoActual;
  final double porcentajeAlcanzado;
  final VoidCallback onTap;

  const CooperacionCard({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.montoObjetivo,
    required this.montoActual,
    required this.porcentajeAlcanzado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila de la fecha ir a detalle de Cooperación
          Row(
            children: [
              // Primer elemento con ancho fijo (70% del total)
              Expanded(
                flex: 7,
                child: Text(
                  nombre ?? "Cooperación",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 25,
                  width: 45,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          // Subtítulo: Descripción o estado
          Text(
            descripcion ?? estado ?? "Sin descripción",
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          // Barra de progreso
          LinearProgressIndicator(
            value: porcentajeAlcanzado,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation(Colors.green),
          ),
          const SizedBox(height: 8.0),
          // Montos actuales
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recaudado: \$${montoActual.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 12.0),
              ),
              Text(
                "Objetivo: \$${montoObjetivo.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
