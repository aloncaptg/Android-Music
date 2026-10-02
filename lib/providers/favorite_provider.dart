import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  static const String _storageKey = 'favorite_song_ids';
  SharedPreferences? _prefs;

  final Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;
  bool isFavorite(String songId) => _favoriteIds.contains(songId);

  FavoriteProvider() {
    initStorage();
  }

  Future<void> initStorage() async {
    _prefs ??= await SharedPreferences.getInstance();
    final savedList = _prefs?.getStringList(_storageKey) ?? [];
    _favoriteIds.addAll(savedList);
    notifyListeners();
  }

  Future<void> toggleFavorite(String songId) async {
    if (_favoriteIds.contains(songId)) {
      _favoriteIds.remove(songId);
    } else {
      _favoriteIds.add(songId);
    }

    notifyListeners();

    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs?.setStringList(_storageKey, _favoriteIds.toList());
    } catch (e) {
      debugPrint("Error saving favorites: $e");
    }
  }

  Future<void> clearAll() async {
    _favoriteIds.clear();
    notifyListeners();
    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs?.remove(_storageKey);
    } catch (e) {
      debugPrint("Error clearing favorites: $e");
    }
  }
}
