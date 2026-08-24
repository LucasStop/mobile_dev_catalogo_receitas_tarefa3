import 'package:flutter/material.dart';
import 'receita_model.dart';

class DetalhesReceitaScreen extends StatelessWidget {
  final Receita receita;

  const DetalhesReceitaScreen({super.key, required this.receita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receita.titulo),
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
