enum UserType {
  cidadao,
  empresa,
  municipio,
  none, // Para o estado inicial ou deslogado
}

class AuthenticationService {
  Future<UserType> login(String username, String password, UserType requestedType) async {
    // Simula um atraso de rede
    await Future.delayed(const Duration(seconds: 2));

    // Lógica de autenticação simulada
    if (username == 'cidadao' && password == 'pass' && requestedType == UserType.cidadao) {
      return UserType.cidadao;
    } else if (username == 'empresa' && password == 'pass' && requestedType == UserType.empresa) {
      return UserType.empresa;
    } else if (username == 'municipio' && password == 'pass' && requestedType == UserType.municipio) {
      return UserType.municipio;
    } else {
      return UserType.none; // Falha na autenticação
    }
  }
}
