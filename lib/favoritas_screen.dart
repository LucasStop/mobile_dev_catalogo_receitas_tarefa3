import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'favoritas_provider.dart';
import 'recipe_card.dart';

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
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  Text(
                    'Você ainda não tem receitas favoritas.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: receitasFavoritas.length,
              itemBuilder: (ctx, index) => RecipeCard(receita: receitasFavoritas[index]),
            ),
    );
  }
}
