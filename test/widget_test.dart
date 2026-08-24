import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:mobile_dev_catalogo_receitas_tarefa3/main.dart';
import 'package:mobile_dev_catalogo_receitas_tarefa3/favoritas_provider.dart';

Widget pumpApp() {
  return ChangeNotifierProvider(
    create: (context) => FavoritasProvider(),
    child: const MyApp(),
  );
}

void main() {
  testWidgets('lista mostra as receitas mockadas', (tester) async {
    await tester.pumpWidget(pumpApp());

    expect(find.text('Bolo de Chocolate'), findsOneWidget);
    expect(find.text('Macarrão à Carbonara'), findsOneWidget);
  });

  testWidgets('tocar numa receita navega pra tela de detalhes', (tester) async {
    await tester.pumpWidget(pumpApp());

    await tester.tap(find.text('Bolo de Chocolate'));
    await tester.pumpAndSettle();

    expect(find.text('Ingredientes'), findsOneWidget);
    expect(find.text('Modo de Preparo'), findsOneWidget);
  });

  testWidgets('favoritar nos detalhes atualiza o ícone na lista', (tester) async {
    await tester.pumpWidget(pumpApp());

    await tester.tap(find.text('Bolo de Chocolate'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.favorite_border).last);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    final coracaoNaLista = find.descendant(
      of: find.widgetWithText(ListTile, 'Bolo de Chocolate'),
      matching: find.byIcon(Icons.favorite),
    );
    expect(coracaoNaLista, findsOneWidget);
  });

  testWidgets('tela de favoritos mostra mensagem quando vazia', (tester) async {
    await tester.pumpWidget(pumpApp());

    final botaoFavoritos = find.descendant(
      of: find.byType(AppBar),
      matching: find.byIcon(Icons.favorite),
    );
    await tester.tap(botaoFavoritos);
    await tester.pumpAndSettle();

    expect(find.text('Você ainda não tem receitas favoritas.'), findsOneWidget);
  });

  testWidgets('tela de favoritos filtra só as receitas favoritadas', (tester) async {
    await tester.pumpWidget(pumpApp());

    await tester.tap(find.text('Bolo de Chocolate'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.favorite_border).last);
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    final botaoFavoritos = find.descendant(
      of: find.byType(AppBar),
      matching: find.byIcon(Icons.favorite),
    );
    await tester.tap(botaoFavoritos);
    await tester.pumpAndSettle();

    expect(find.text('Bolo de Chocolate'), findsOneWidget);
    expect(find.text('Macarrão à Carbonara'), findsNothing);
  });
}
