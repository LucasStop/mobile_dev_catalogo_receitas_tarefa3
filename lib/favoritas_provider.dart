import 'package:flutter/material.dart';

class FavoritasProvider extends ChangeNotifier {
  final List<String> _idsReceitasFavoritas = [];

  List<String> get idsReceitasFavoritas => _idsReceitasFavoritas;

  bool isFavorita(String id) {
    return _idsReceitasFavoritas.contains(id);
  }

  void toggleFavorita(String id) {
    if (isFavorita(id)) {
      _idsReceitasFavoritas.remove(id);
    } else {
      _idsReceitasFavoritas.add(id);
    }
    notifyListeners();
  }
}
