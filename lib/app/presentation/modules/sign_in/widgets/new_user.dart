
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';
import 'package:tesora/gen/i18n/translations_mobil.g.dart';

class RegisterRow extends StatelessWidget {
  final TranslationsCommons text;

  const RegisterRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
    
          ),
          child: Text(
            text.loguin.new_user,
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(RoutePath.crearUsuarios);
          },
          child: Text(
            text.loguin.register_now,
            style: const TextStyle(
              fontSize: 14,
              color: colorPrincipal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
