import 'package:flutter/material.dart';
import 'receita_model.dart';
import 'detalhes_receita_screen.dart';

final List<Receita> DADOS_RECEITAS = [
  Receita(
    id: 'r1',
    titulo: 'Bolo de Chocolate',
    ingredientes: 'Farinha, ovos, chocolate em pó, açúcar, leite, fermento.',
    modoDePreparo:
        'Misture os ingredientes secos e os líquidos separadamente, junte tudo e asse a 180°C por 40 minutos.',
    imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600',
  ),
  Receita(
    id: 'r2',
    titulo: 'Macarrão à Carbonara',
    ingredientes: 'Espaguete, ovos, queijo parmesão, bacon, pimenta-do-reino.',
    modoDePreparo:
        'Cozinhe a massa, frite o bacon, misture com ovos e queijo fora do fogo pra não talhar.',
    imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=600',
  ),
  Receita(
    id: 'r3',
    titulo: 'Salada Caesar',
    ingredientes: 'Alface romana, croutons, parmesão, molho caesar, frango grelhado.',
    modoDePreparo: 'Monte a alface picada, adicione o frango, croutons, queijo e regue com o molho.',
    imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=600',
  ),
  Receita(
    id: 'r4',
    titulo: 'Lasanha à Bolonhesa',
    ingredientes: 'Massa de lasanha, molho bolonhesa, molho branco, queijo muçarela.',
    modoDePreparo: 'Monte camadas alternadas de massa, molhos e queijo, asse até gratinar.',
    imageUrl: 'https://images.unsplash.com/photo-1619895092538-128341789043?w=600',
  ),
  Receita(
    id: 'r5',
    titulo: 'Pizza Margherita',
    ingredientes: 'Massa de pizza, molho de tomate, muçarela, manjericão fresco.',
    modoDePreparo: 'Espalhe o molho na massa, cubra com muçarela e asse em forno bem quente.',
    imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600',
  ),
  Receita(
    id: 'r6',
    titulo: 'Brigadeiro',
    ingredientes: 'Leite condensado, chocolate em pó, manteiga, granulado.',
    modoDePreparo:
        'Cozinhe o leite condensado com chocolate e manteiga até desgrudar da panela, enrole em bolinhas.',
    imageUrl: 'https://images.unsplash.com/photo-1610450949065-1f2841536c88?w=600',
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Receitas',
      home: const ListaReceitasScreen(),
    );
  }
}

class ListaReceitasScreen extends StatelessWidget {
  const ListaReceitasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Receitas'),
      ),
      body: ListView.builder(
        itemCount: DADOS_RECEITAS.length,
        itemBuilder: (ctx, index) {
          final receita = DADOS_RECEITAS[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(receita.imageUrl),
                onBackgroundImageError: (_, _) {},
                child: Text(receita.id.toUpperCase()),
              ),
              title: Text(receita.titulo),
              subtitle: const Text('Clique para ver detalhes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesReceitaScreen(receita: receita),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
