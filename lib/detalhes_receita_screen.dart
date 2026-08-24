import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'receita_model.dart';
import 'favoritas_provider.dart';
import 'theme.dart';

class DetalhesReceitaScreen extends StatelessWidget {
  final Receita receita;

  const DetalhesReceitaScreen({super.key, required this.receita});

  @override
  Widget build(BuildContext context) {
    final favoritasProvider = context.watch<FavoritasProvider>();
    final isFav = favoritasProvider.isFavorita(receita.id);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    receita.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.restaurant, size: 48),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 16,
                  child: SafeArea(
                    left: false,
                    right: false,
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: _BotaoCircular(
                        icon: Icons.arrow_back,
                        tooltip: 'Back',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 16,
                  child: SafeArea(
                    left: false,
                    right: false,
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: _BotaoCircular(
                        icon: isFav ? Icons.favorite : Icons.favorite_border,
                        iconColor: isFav ? Colors.red : Colors.black87,
                        onPressed: () {
                          context.read<FavoritasProvider>().toggleFavorita(receita.id);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              transform: Matrix4.translationValues(0, -20, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receita.titulo,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 20),
                      _Secao(
                        icone: Icons.shopping_basket_outlined,
                        titulo: 'Ingredientes',
                        texto: receita.ingredientes,
                      ),
                      const SizedBox(height: 20),
                      _Secao(
                        icone: Icons.soup_kitchen_outlined,
                        titulo: 'Modo de Preparo',
                        texto: receita.modoDePreparo,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BotaoCircular extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String? tooltip;
  final VoidCallback onPressed;

  const _BotaoCircular({
    required this.icon,
    this.iconColor = Colors.black87,
    this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        tooltip: tooltip,
        onPressed: onPressed,
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String texto;

  const _Secao({required this.icone, required this.titulo, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icone, color: corDestaque, size: 20),
            const SizedBox(width: 8),
            Text(titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 8),
        Text(texto, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.5)),
      ],
    );
  }
}
