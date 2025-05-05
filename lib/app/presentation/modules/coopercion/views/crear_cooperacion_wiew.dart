import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/text_size.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';
import 'package:tesora/app/presentation/modules/home/controllers/crear_coperacion_controller.dart';
import 'package:tesora/app/presentation/modules/home/widgets/boton_crear_coop_widget.dart';
import 'package:tesora/app/presentation/modules/home/widgets/custom_date_picker.dart';
import 'package:tesora/app/presentation/modules/home/widgets/text_fields/descripcion_field.dart';
import 'package:tesora/app/presentation/modules/home/widgets/text_fields/monto_objetivo_field.dart';
import 'package:tesora/app/presentation/modules/home/widgets/text_fields/nombre_field.dart';
import 'package:tesora/app/presentation/modules/home/widgets/text_fields/numero_cuenta_field.dart';

class CrearCooperacionWiew extends StatelessWidget with ControllersMixin {
  CrearCooperacionWiew({super.key});

  @override
  Widget build(BuildContext context) {
    final crearCoperacionController = getCrearCooperacionController(context);
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController descripcionController = TextEditingController();
    final TextEditingController montoController = TextEditingController();
    final TextEditingController cuentaPagoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorSueve,
        title: autoSizeTextCards(
            titulo: "Crear Cooperación", fontSize: 24, align: TextAlign.start),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorPrincipal),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo Nombre
              NombreField(
                  controller: nombreController, // Remueve el controlador
                  onChanged: (value) {
                // Lógica a ejecutar al cambiar
                    crearCoperacionController.actualizarNombre(value!);
                  }),
              const SizedBox(height: 12),

              // Campo Descripción
              DescripcionField(
                controller: descripcionController,
                onChanged: (value) => crearCoperacionController
                    .actualizarDescripcion(value!),
              ),
              const SizedBox(height: 12),

              // Campo Monto Objetivo
              MontoObjetivoField(
                controller: montoController,
                onChanged: (value) => crearCoperacionController
                    .actualizarMontoObjetivo(value!),
              ),
              const SizedBox(height: 12),
              //
              NumeroCuentaField(
                controller: cuentaPagoController,
                onChanged: (value) => crearCoperacionController
                    .actualizarNumeroCuenta(value!),
              ),
              const SizedBox(height: 12),

              Selector<CrearCoperacionController, DateTime?>(
                  selector: (context, controller) =>
                      controller.state.fechaInicio,
                  builder: (context, fechaInicio, child) {
                    return CustomDatePicker(
                      label: "Fecha de Inicio",
                      selectedDate: fechaInicio,
                      onSelectDate: (pickedDate) => crearCoperacionController
                          .actualizarFechaInicio(pickedDate),
                    );
                  }),

              const SizedBox(height: 12),
              Selector<CrearCoperacionController, DateTime?>(
                  selector: (context, controller) => controller.state.fechaFin,
                  builder: (context, fechafin, child) {
                    return CustomDatePicker(
                      label: "Fecha Final",
                      selectedDate: fechafin,
                      onSelectDate: (pickedDate) => crearCoperacionController
                          .actualizarFechaFin(pickedDate),
                    );
                  }),

              const SizedBox(height: 12),

              // Botón Guardar
              SizedBox(
                width: double.infinity,
                child: BotonCrearCoopWidget(
                  botonTitulo: "Guardar",
                  crearCooperacionController: crearCoperacionController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
