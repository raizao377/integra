import 'package:flutter/material.dart';
import 'package:integra_app/login_screen.dart';
import 'package:integra_app/home_screen.dart';
import 'package:integra_app/authentication_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integra App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        // A HomeScreen é acessada após o login, o userType será passado via argumentos ou Provider
        // Por simplicidade, aqui apenas definimos a rota, o userType será gerenciado na navegação
        // A rota '/home' não será usada diretamente com `Navigator.pushNamed` sem argumentos.
        // A navegação para HomeScreen será feita com `MaterialPageRoute` passando o UserType.
      },
    );
  }
}
