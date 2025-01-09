import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

part 'menu_state.freezed.dart';

@freezed
class MenuState with _$MenuState {
  factory MenuState({

    @Default(0) int item,
    // Elemento actual seleccionado en el menú.
    @Default(RoutePath.splash) String currentMenuItem,
    // Indica si el drawer está abierto.
    @Default(false) bool isDrawerOpen,
    // Lista de elementos del menú.
    @Default([]) List<String> menuItems,
    // Nombre del usuario para mostrar en el drawer.
    String? userName,
    // Foto de perfil del usuario.
    String? userProfilePicture,
    // Contador de notificaciones.
    @Default(0) int notificationsCount,
  }) = _MenuState;
}
