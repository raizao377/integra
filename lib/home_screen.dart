import 'package:flutter/material.dart';

void main() {
  runApp(const IntegraApp());
}

class IntegraApp extends StatelessWidget {
  const IntegraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integra - Serviços Públicos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: "Roboto",
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Integra", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Olá, cidadão!", style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Card(
              elevation: 4,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBAcgmJVPXsKKKACHOyVG1nBoiMXLy3gQ8dTQpDCQKZkltD44CZXPnLlAI89G1BeCdzwY4MZyo62GB_Ob-P3COu5pFqSEtxP8IPYXnmlpm9p2Pv9lt8okRxtNouijL-x1IUybowGbL0f93X0F_ZElOm38Unl5MO1XipKa3TGGWlh3ifW2P_02ShQBMZmYADxu54tX2s67uqx-4gm8RAr1N9W7b4cPFcHPW6izRGwI2oBbkOSRRZvnHV_kPC7mGZtdBmeyq5pySwyqI"),
                ),
                title: const Text("Seu portal de serviços"),
                subtitle: const Text("Acesse tudo em um só lugar."),
              ),
            ),
            const SizedBox(height: 20),

            const Text("Serviços mais acessados",
                style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _ServiceButton(
                  icon: Icons.lightbulb,
                  label: "Reparo na iluminação",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ServiceDetailScreen()),
                    );
                  },
                ),
                const _ServiceButton(icon: Icons.park, label: "Poda de árvores"),
                const _ServiceButton(icon: Icons.construction, label: "Tapa buraco"),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Recomendados para você",
                style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            Card(
              elevation: 3,
              child: ListTile(
                title: const Text("Ajude a salvar vidas"),
                subtitle:
                    const Text("Faça uma doação de sangue no hemocentro."),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Início"),
          NavigationDestination(icon: Icon(Icons.event), label: "Agenda"),
          NavigationDestination(icon: Icon(Icons.search), label: "Pesquisa"),
          NavigationDestination(
              icon: Icon(Icons.account_balance_wallet), label: "Carteira"),
        ],
      ),
    );
  }
}


class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
        title: const Text("Solicitar reparo na iluminação"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapScreen()));
              },
              child: const Text("Iniciar"),
            ),
            const SizedBox(height: 10),
            const Text("Última atualização: 10/05/2024",
                style: TextStyle(fontSize: 12)),

            const SizedBox(height: 20),
            const ExpansionTile(
              title: Text("O que é"),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "Informe falhas em postes de luz, como lâmpadas queimadas ou oscilações, para ser feito o conserto."),
                )
              ],
            ),
            const ExpansionTile(title: Text("Público")),
            const ExpansionTile(title: Text("Como fazer")),
            const ExpansionTile(title: Text("Documentação necessária")),
            const ExpansionTile(title: Text("Quanto tempo leva")),
          ],
        ),
      ),
    );
  }
}


class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Município de ..."),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Informe o local do problema",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Text("Posicione o marcador na rua onde encontrou o problema."),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuCHJvKrRmqJ0izri4SaX-Q9b8FbYAzrWneJ8T0F1W5BQivYyl1MG9hN7eEerpL7pLo7zFjPRoY226vku8b0xddAD9FTIHpFweIO5tU9QCZr1yluhJp9z_ME7EFLeTdakrPq0lG2X7wpVVWyYq-G8WPWLlCHxSyWUu1SGmxeLIlrxaHGR3qO0K3-0GoELKO0KZS-xPdvQaYNKIofQaVCczI5TmKF6FmYjcT6OaBYs2NOHdhGib54IghacF_JzfDvr6OUW6J8riuxN3E",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        const Icon(Icons.location_on,
                            color: Colors.red, size: 50),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.error, color: Colors.red),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text("Localização fora da área de cobertura.")),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Voltar"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: null, // Desativado
                                child: const Text("Avançar"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ServiceButton(
      {required this.icon, required this.label, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

