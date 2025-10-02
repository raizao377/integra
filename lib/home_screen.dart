import 'package:flutter/material.dart';
import 'authentication_service.dart';

class HomeScreen extends StatelessWidget {
  final UserType userType;

  const HomeScreen({super.key, required this.userType});

  String _getUserTypeString(UserType type) {
    switch (type) {
      case UserType.cidadao:
        return 'Cidadão';
      case UserType.empresa:
        return 'Empresa';
      case UserType.municipio:
        return 'Município';
      case UserType.none:
        return 'Visitante';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove o botão de voltar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo, ${_getUserTypeString(userType)}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Esta é a página inicial do aplicativo Integra.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/',
                ); // Volta para a tela de login
              },
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
