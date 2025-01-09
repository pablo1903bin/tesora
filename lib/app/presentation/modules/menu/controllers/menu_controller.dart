import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/modules/menu/controllers/state/menu_state.dart';
import 'package:tesora/app/states/state_notifier.dart';

class MenuController extends StateNotifier<MenuState> {
  final GlobalKey<ScaffoldState> scaffoldKey;

  MenuController(this.scaffoldKey) : super(MenuState());

  void toggleDrawer() {
    if (scaffoldKey.currentState != null) {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        scaffoldKey.currentState!.openEndDrawer();
        notifica(state.copyWith(isDrawerOpen: false));
      } else {
        scaffoldKey.currentState!.openDrawer();
        notifica(state.copyWith(isDrawerOpen: true));
      }
    }
  }

  void updateCurrentMenuItem(String item) {
    notifica(state.copyWith(currentMenuItem: item));
  }

  bool isDrawerOpen() {
    return state.isDrawerOpen;
  }
}
