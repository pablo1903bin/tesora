import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

import '../../../mixin/i18n_mixin.dart';

class RegisterRow extends StatelessWidget with I18NMixin {
  const RegisterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText.rich(
        TextSpan(
          style: const TextStyle(fontSize: 12, color: colorAlterno4),
          children: [
            TextSpan(text: '${i18n.loguin.new_user} '),
            TextSpan(
              text: i18n.loguin.register_now,
              style: const TextStyle(
                fontSize: 14,
                color: colorPrincipal,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  GoRouter.of(context).push(RoutePath.crearUsuarios);
                },
            ),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        minFontSize: 10,
      ),
    );
  }
}
