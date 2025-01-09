import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';

class CooperacionesVacias extends StatelessWidget with ControllersMixin {
  const CooperacionesVacias({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Aún no hay cooperaciones disponibles',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
