import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'receita_model.dart';
import 'favoritas_provider.dart';

class DetalhesReceitaScreen extends StatelessWidget {
  final Receita receita;

  const DetalhesReceitaScreen({super.key, required this.receita});

  @override
  Widget build(BuildContext context) {
    final favoritasProvider = context.watch<FavoritasProvider>();
    final isFav = favoritasProvider.isFavorita(receita.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(receita.titulo),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              context.read<FavoritasProvider>().toggleFavorita(receita.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                receita.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 220,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.restaurant, size: 48),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('Ingredientes', style: Theme.of(context).textTheme.titleLarge),
            Text(receita.ingredientes),
            const SizedBox(height: 20),
            Text('Modo de Preparo', style: Theme.of(context).textTheme.titleLarge),
            Text(receita.modoDePreparo),
          ],
        ),
      ),
    );
  }
}
