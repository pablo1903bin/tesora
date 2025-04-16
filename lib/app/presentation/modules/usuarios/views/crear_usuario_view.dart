import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';

import '../../../../domain/models/usuario/crear_usuario_request.dart';
import '../../../../domain/models/usuario/register_response.dart';
import '../../../mixin/i18n_mixin.dart';
import '../../../routes/route_path.dart';
import '../../sign_in/controllers/auth_controller.dart';
import '../widgets/dialogs.dart';
import '../widgets/loading_overlay.dart';

class CrearUsuarioView extends StatefulWidget with I18NMixin {
  const CrearUsuarioView({super.key});

  @override
  CrearUsuarioPageState createState() => CrearUsuarioPageState();
}

class CrearUsuarioPageState extends State<CrearUsuarioView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  void _startLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: scaFold());
  }

// Método auxiliar para construir campos de texto
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
    bool isNumeric = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumeric
          ? [
              FilteringTextInputFormatter.digitsOnly, // Solo permite dígitos
              LengthLimitingTextInputFormatter(10), // Limita a 10 caracteres
            ]
          : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: colorAlterno4, // Color del texto de la etiqueta (label)
          fontSize: 16, // Tamaño de la etiqueta (opcional)
        ),
        prefixIcon: Icon(icon, color: colorSecundario),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: colorSecundario, // Azul claro cuando no está interactuando
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: colorSecundario, // Azul más intenso cuando está enfocado
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red, // Rojo para bordes con error
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color:
                Colors.red, // Rojo más intenso cuando hay error y está enfocado
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 244, 244, 244),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa un $label';
            }
            return null;
          },
    );
  }

  Future<void> _crearUsuario() async {
    final usuarioRequest = CrearUsuarioRequest(
      username: _usernameController.text,
      password: _passwordController.text,
      name: _nameController.text,
      apellido: _apellidoController.text,
      telefono: _telefonoController.text,
      email: _emailController.text,
    );

    if (_formKey.currentState!.validate()) {
      _startLoading(true);
      getAuthController(context).registerUser(usuarioRequest);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget scaFold() {
    return Scaffold(
        body: Scaffold(
      backgroundColor: colorAlterno1,
      appBar: AppBar(
        backgroundColor: colorAlterno1,
        automaticallyImplyLeading:
            false, // Evitar el espaciado automático del ícono
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: colorPrincipal),
              onPressed: () {
                context.go(RoutePath.loguin);
              },
            ),
            const SizedBox(
              width: 40,
            ),
            const Text(
              'CREAR USUARIO',
              style: TextStyle(
                color: colorPrincipal,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Selector<AuthController, RegisterResponse?>(
                selector: (context, authController) =>
                    authController.state.registerResponse,
                builder: (context, registerResponse, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _startLoading(false);
                  });

                  if (registerResponse != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Dialogs.showSuccessDialog(
                          context, registerResponse.username);
                    });
                  }

                  return const SizedBox.shrink();
                },
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    // Campos de entrada
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Nombre de usuario',
                      icon: Icons.account_box,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _nameController,
                      label: 'Nombre o nombres',
                      icon: Icons.account_box,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _apellidoController,
                      label: 'Apellidos',
                      icon: Icons.account_box_outlined,
                    ),

                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _telefonoController,
                      label: 'Teléfono',
                      icon: Icons.phone,
                      isNumeric: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un número de teléfono';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'No. de teléfono a 10 dígitos y solo números';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Correo',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Contraseña',
                      icon: Icons.lock,
                      obscureText: false,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Repita su contraseña',
                      icon: Icons.lock,
                      obscureText: false,
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 450, // Cambia el valor para ajustar el ancho
                      child: ElevatedButton(
                        onPressed: _crearUsuario,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          backgroundColor: colorPrincipal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Crear Usuario',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  AuthController getAuthController(BuildContext context) {
    return Provider.of<AuthController>(context, listen: false);
  }
}
/** return Scaffold(
      backgroundColor: colorAlterno1,
      appBar: AppBar(
        backgroundColor: colorAlterno1,
        automaticallyImplyLeading:
            false, // Evitar el espaciado automático del ícono
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: colorPrincipal),
              onPressed: () {
                context.go(RoutePath.loguin);
              },
            ),
            const SizedBox(
              width: 40,
            ),
            const Text(
              'CREAR USUARIO',
              style: TextStyle(
                color: colorPrincipal,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    // Campos de entrada
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Nombre de usuario',
                      icon: Icons.account_box,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _nameController,
                      label: 'Nombre o nombres',
                      icon: Icons.account_box,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _apellidoController,
                      label: 'Apellidos',
                      icon: Icons.account_box_outlined,
                    ),

                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _telefonoController,
                      label: 'Teléfono',
                      icon: Icons.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un número de teléfono';
                        }
                        // Validar que el número tenga exactamente 10 dígitos y solo contenga números
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'No. de teléfono a 10 dígitos y solo números';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Correo',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Contraseña',
                      icon: Icons.lock,
                      obscureText: false,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Repita su contraseña',
                      icon: Icons.lock,
                      obscureText: false,
                    ),
                    const SizedBox(height: 50),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: 450, // Cambia el valor para ajustar el ancho
                            child: ElevatedButton(
                              onPressed: _crearUsuario,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 15,
                                ),
                                backgroundColor: colorPrincipal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Crear Usuario',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
 * 
 * 
 */