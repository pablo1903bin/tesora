import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/fields/custom_text_field.dart';

class NombreField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onChanged;
  final InputDecoration? decoration;
  final ValueNotifier<bool> obscureTextNotifier;

  NombreField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.decoration,
    ValueNotifier<bool>? obscureTextNotifier,
  }) : obscureTextNotifier = obscureTextNotifier ?? ValueNotifier(false);

  // Función de validación para el campo de usuario
  String? validateUser(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El campo Nombre no puede estar vacío o contener solo espacios';
    }
    if (value.contains(' ')) {
      return 'El campo Nombre no debe contener espacios';
    }
    if (value.length <= 4) {
      return 'El campo Nombre debe tener al menos 4 caracteres';
    }
    return null; // Retorna null si no hay error (éxito)
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: "Nombre",
      obscureTextNotifier: obscureTextNotifier,
      decoration: (decoration ?? const InputDecoration()).copyWith(
        // Cambia el color de la etiqueta (labelText)
        labelStyle: const TextStyle(
          color: colorPrincipal, // Cambia a tu color deseado
          fontSize: 16, // Opcional, puedes ajustar el tamaño
        ),
        labelText: "Nombre",
        suffixIcon: null, // No es necesario ícono para este campo
        // Define el borde cuando el TextField está enfocado
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorPrincipal, width: 2.0),
        ),
        // Define el borde cuando el TextField está habilitado, pero no enfocado
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorSecundario, width: 1.5),
        ),
        // Define el borde cuando el TextField está deshabilitado
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorPrincipal, width: 1.5),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      textStyle: const TextStyle(fontSize: 16, color: colorPrincipal),
      onChanged: (value) {
        onChanged(value);
      },
      validator: validateUser,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}