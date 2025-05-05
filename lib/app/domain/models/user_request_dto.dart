import 'package:flutter/material.dart';

class UserRequestDto {
  String? username;
  String? password;
  BuildContext? context;

  // Constructor
  UserRequestDto({this.username, this.password, this.context});

  @override
  String toString() {
    return 'Usuario: $username, Contraseña: $password';
  }
}
