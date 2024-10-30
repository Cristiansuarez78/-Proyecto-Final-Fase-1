import 'package:flutter/material.dart';

class RecoverPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
        backgroundColor: const Color(0xFF2E7D6E),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [Color(0xFF2E7D6E), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.lock,
                    size: 100,
                    color: Colors.white, // Cambiado a blanco
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Olvidaste tu Usuario o tu Clave, Ambas?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'No te preocupes, te enviaremos instrucciones para restablecerlo.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Campo para ingresar el correo
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un correo';
                      }
                      final emailPattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      final isValidEmail = RegExp(emailPattern).hasMatch(value);
                      if (!isValidEmail) {
                        return 'Por favor ingresa un correo válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Botón de recuperar contraseña
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Instrucciones enviadas a $email')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D6E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Recuperar Contraseña'),
                  ),
                  const SizedBox(height: 20),

                  // Botón de volver al LoginScreen
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Regresar a la pantalla de inicio de sesión
                    },
                    child: const Text(
                      'Volver a Iniciar Sesión',
                      style: TextStyle(color: Color(0xFF2E7D6E)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
