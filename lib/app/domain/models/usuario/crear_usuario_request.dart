class CrearUsuarioRequest {
  final String username;
  final String password;
  final String name;
  final String apellido;
  final String telefono;
  final String email;

  CrearUsuarioRequest({
    required this.username,
    required this.password,
    required this.name,
    required this.apellido,
    required this.telefono,
    required this.email,
  });

  // Método para convertir la clase a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'apellido': apellido,
      'telefono': telefono,
      'email': email,
    };
  }
}
