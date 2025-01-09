import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/text_size.dart';

class ResumenCard extends StatefulWidget {
  final String titulo; // Título de la tarjeta
  final String monto; // Monto total
  final Color colorFondo; // Color de fondo
  final Color colorTexto; // Color del texto
  final VoidCallback? onTap; // Acción al pulsar la tarjeta

  const ResumenCard({
    super.key,
    required this.titulo,
    required this.monto,
    required this.colorFondo,
    required this.colorTexto,
    this.onTap,
  });

  @override
  State<ResumenCard> createState() => _ResumenCardState();
}

class _ResumenCardState extends State<ResumenCard>  {
  double _scale = 1.0; // Escala inicial

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        // Reduce la escala cuando se presiona
        setState(() {
          _scale = 1.1;
        });
      },
      onTapUp: (_) {
        // Vuelve a la escala normal cuando se suelta
        setState(() {
          _scale = 1.0;
        });
      },
      onTapCancel: () {
        // Vuelve a la escala normal si se cancela el toque
        setState(() {
          _scale = 1.0;
        });
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: widget.colorFondo,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              autoSizeTextCards(titulo: widget.titulo, fontSize: 16),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: autoSizeTextCards(titulo: widget.monto, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
