import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialHelperCustom {
  /// Método estático para crear targets dinámicamente
  static void createTargets({
    required List<TargetFocus> targets,
    required List<GlobalKey> keys,
    required List<Map<String, dynamic>> descriptions,
  }) {
    if (keys.length != descriptions.length) {
      throw ArgumentError(
          "La cantidad de keys debe coincidir con la cantidad de descripciones.");
    }

    for (int i = 0; i < keys.length; i++) {
      final showBackButton = descriptions[i]["showBackButton"] ?? false;
      final showCheckbox = descriptions[i]["showCheckbox"] ?? false;

      targets.add(
        TargetFocus(
          identify: "Target $i",
          keyTarget: keys[i],
          color: const Color.fromARGB(255, 1, 42, 94),
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      descriptions[i]["title"] ?? "Sin Título",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        descriptions[i]["description"] ?? "Sin Descripción",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (showBackButton)
                      ElevatedButton(
                        onPressed: () {
                          controller.previous();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        child: const Icon(
                          Icons.chevron_left,
                          size: 24,
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (showCheckbox)
                      Row(
                        children: [
                          Checkbox(
                            value: descriptions[i]["checkboxValue"] ?? false,
                            onChanged: (value) {
                              descriptions[i]["onCheckboxChanged"]
                                  ?.call(value);
                            },
                          ),
                          const Text(
                            "No volver a mostrar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                  ],
                );
              },
            )
          ],
          shape: ShapeLightFocus.RRect,
          radius: 5,
        ),
      );
    }
  }
}
