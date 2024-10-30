import 'package:flutter/material.dart';
import 'LoginScreen.dart'; // Importa tu pantalla de inicio de sesión
import 'UserScreen.dart'; // Importa tu pantalla de usuario
import 'AdminScreen.dart'; // Importa tu pantalla de administrador

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CUNAPE Delivery App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Pantalla de inicio de sesión
        '/user': (context) => UserScreen(), // Pantalla para usuarios regulares
        '/admin': (context) => AdminScreen(), // Pantalla para administradores
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => LoginScreen());
      },
    );
  }
}
