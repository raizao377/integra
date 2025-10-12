// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Aplicativo principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

/// Tela de login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // Validador simples de e-mail
  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Informe seu e-mail';
    final email = v.trim();
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!regex.hasMatch(email)) return 'E-mail inválido';
    return null;
  }

  // Validador de senha
  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Informe sua senha';
    if (v.length < 6) return 'Senha deve ter ao menos 6 caracteres';
    return null;
  }

  // Mock de autenticação (substituir por chamada real)
  Future<bool> _authenticate({required String email, required String password}) async {
    // Simula latência de rede
    await Future.delayed(const Duration(seconds: 2));

    // Exemplo: aceita email "user@example.com" e senha "123456"
    if (email.toLowerCase() == 'user@example.com' && password == '123456') {
      return true;
    }

    // falha por padrão
    return false;
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailCtrl.text.trim();
    final pwd = _passwordCtrl.text;

    try {
      final ok = await _authenticate(email: email, password: pwd);

      if (ok) {
        // Navega para home substituindo a rota atual
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen(userEmail: email)),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail ou senha incorretos')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao autenticar: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _onForgotPassword() {
    showDialog(
      context: context,
      builder: (context) {
        final _forgotEmailCtrl = TextEditingController();
        return AlertDialog(
          title: const Text('Esqueci a senha'),
          content: TextField(
            controller: _forgotEmailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Informe seu e-mail',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aqui você chamaria o serviço de recuperação de senha
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Link de recuperação enviado para ${_forgotEmailCtrl.text}')),
                );
              },
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Layout centralizado com card
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cabeçalho
                    Row(
                      children: const [
                        FlutterLogo(size: 48),
                        SizedBox(width: 12),
                        Text('Integra App', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Formulário
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordCtrl,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: _onForgotPassword,
                                child: const Text('Esqueci a senha'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Exemplo: ir para tela de registro
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Ir para registro (não implementado)')),
                                  );
                                },
                                child: const Text('Criar conta'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Botão de login
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _onSubmit,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text('Entrar'),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Separator com opção de login social (placeholder)
                          Row(children: const <Widget>[
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('ou'),
                            ),
                            Expanded(child: Divider()),
                          ]),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Placeholder - aqui poderia integrar com Google/Facebook
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login social não implementado')),
                                );
                              },
                              icon: const Icon(Icons.login),
                              label: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text('Entrar com Google'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tela simples após login
class HomeScreen extends StatelessWidget {
  final String userEmail;
  const HomeScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Deslogar e voltar para tela de login
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text('Bem vindo, $userEmail', style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
