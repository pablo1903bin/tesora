class RegisterResponse {
  final int id;
  final String username;
  final String password;
  final String name;
  final String apellido;
  final String telefono;
  final String email;
  final String fechaCreacion;
  final String role;
  final String token;

  RegisterResponse({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.apellido,
    required this.telefono,
    required this.email,
    required this.fechaCreacion,
    required this.role,
    required this.token,
  });

  // Método para convertir un JSON a un objeto RegisterResponse
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      name: json['name'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      email: json['email'],
      fechaCreacion: json['fechaCreacion'],
      role: json['role'],
      token: json['token'],
    );
  }

  // Método para convertir un objeto RegisterResponse a un JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'apellido': apellido,
      'telefono': telefono,
      'email': email,
      'fechaCreacion': fechaCreacion,
      'role': role,
      'token': token,
    };
  }
}
