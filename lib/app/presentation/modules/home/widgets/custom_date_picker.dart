import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/date_formatter.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onSelectDate;

  const CustomDatePicker({
    super.key,
    required this.label,
    this.selectedDate,
    required this.onSelectDate,
  });

  // Método para abrir el selector de fechas
  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // Fecha mínima
      lastDate: DateTime(2100), // Fecha máxima
    );

    if (pickedDate != null) {
      onSelectDate(pickedDate); // Llama al callback con la fecha seleccionada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Etiqueta del campo
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),

        // Contenedor y botón
        Row(
          children: [
            // Contenedor que muestra la fecha seleccionada
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  selectedDate != null
                      ? DateFormatter.formatFullDate(
                          selectedDate) // Formatea la fecha
                      : 'Seleccionar',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Botón para abrir el selector de fechas
            ElevatedButton(
              onPressed: () => _pickDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(50, 50), // Tamaño fijo del botón
              ),
              child: const Icon(Icons.calendar_today, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
