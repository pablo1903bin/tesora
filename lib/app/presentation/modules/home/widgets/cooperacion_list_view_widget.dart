import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/modules/home/widgets/cooperacion_card.dart';
import 'package:tesora/app/presentation/modules/home/widgets/cooperaciones_card_container.dart';
import 'package:tesora/app/presentation/modules/home/widgets/flayer_skin.dart';

class CooperacionListView extends StatelessWidget {
  final List<dynamic> cooperaciones;
  final VoidCallback Function(dynamic cooperacion) onItemTap;

  const CooperacionListView({
    super.key,
    required this.cooperaciones,
    required this.onItemTap,
  });

@override
Widget build(BuildContext context) {
  return ListView.builder(
    itemCount: cooperaciones.length, // Número de elementos en la lista
    itemBuilder: (context, index) {
      final cooperacion = cooperaciones[index];
      
      // Calcula el porcentaje alcanzado
      final double montoObjetivo =
          double.tryParse(cooperacion.montoObjetivo ?? "0") ?? 0.0;
      final double porcentajeAlcanzado = montoObjetivo > 0
          ? (cooperacion.montoActual ?? 0) / montoObjetivo
          : 0.0;

      return CooperacionCardContainer(
        child: CardCooperaciones(
          myWidget: CooperacionCard(
            nombre: cooperacion.nombre,
            descripcion: cooperacion.descripcion,
            estado: cooperacion.estado,
            montoObjetivo: montoObjetivo,
            montoActual: cooperacion.montoActual ?? 0.0,
            porcentajeAlcanzado: porcentajeAlcanzado,
            onTap: () => onItemTap(cooperacion),
          ),
        ),
      );
    },
  );
}

}
