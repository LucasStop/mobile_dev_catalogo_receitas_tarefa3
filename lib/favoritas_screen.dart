import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'detalhes_receita_screen.dart';
import 'favoritas_provider.dart';

class FavoritasScreen extends StatelessWidget {
  const FavoritasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritasProvider = context.watch<FavoritasProvider>();
    final receitasFavoritas = DADOS_RECEITAS
        .where((receita) => favoritasProvider.isFavorita(receita.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas Favoritas'),
      ),
      body: receitasFavoritas.isEmpty
          ? const Center(
              child: Text('Você ainda não tem receitas favoritas.'),
            )
          : ListView.builder(
              itemCount: receitasFavoritas.length,
              itemBuilder: (ctx, index) {
                final receita = receitasFavoritas[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(receita.imageUrl),
                      onBackgroundImageError: (_, _) {},
                      child: Text(receita.id.toUpperCase()),
                    ),
                    title: Text(receita.titulo),
                    trailing: const Icon(Icons.favorite, color: Colors.red),
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
