import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/feature/favorites/model/favorite_model.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, List<FavoriteModel>>(
  (ref) => FavoriteNotifier(),
);

class FavoriteNotifier extends StateNotifier<List<FavoriteModel>> {
  FavoriteNotifier() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteData = prefs.getString('favorites');
    if (favoriteData != null) {
      final favoriteList = json.decode(favoriteData) as List;
      state = favoriteList.map((data) => FavoriteModel.fromJson(data)).toList();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteData = json.encode(state.map((e) => e.toJson()).toList());
    await prefs.setString('favorites', favoriteData);
  }

  void addToFavorites(FavoriteModel favorite) {
    state = [...state, favorite];
    _saveFavorites();
  }

  void removeFromFavorites(int id) {
    state = state.where((model) => model.id != id).toList();
    _saveFavorites();
  }

  bool isFavorite(int id) {
    return state.any((model) => model.id == id);
  }
}
