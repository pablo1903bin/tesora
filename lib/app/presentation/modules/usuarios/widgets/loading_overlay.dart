import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Contenido principal de la pantalla
        child,

        // Capa superior que se muestra cuando isLoading es true
        if (isLoading)
          Stack(
            children: [
              // Oscurece la pantalla
              ModalBarrier(
                dismissible: false,
                color: Colors.black.withOpacity(0.5),
              ),

              // Indicador de carga en el centro
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
