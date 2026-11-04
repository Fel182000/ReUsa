import 'package:flutter/material.dart';

class FavoritosProvider extends ChangeNotifier {
  final Set<int> _ids = {};

  int get cantidad => _ids.length;

  bool esFavorito(int id) => _ids.contains(id);

  void alternar(int id) {
    if (!_ids.remove(id)) {
      _ids.add(id);
    }
    notifyListeners();
  }
}
