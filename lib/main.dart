import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'receita_model.dart';
import 'favoritas_provider.dart';
import 'favoritas_screen.dart';
import 'recipe_card.dart';
import 'theme.dart';

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
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritasProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Receitas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: corDestaque),
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritasScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        itemCount: DADOS_RECEITAS.length,
        itemBuilder: (ctx, index) => RecipeCard(receita: DADOS_RECEITAS[index]),
      ),
    );
  }
}
