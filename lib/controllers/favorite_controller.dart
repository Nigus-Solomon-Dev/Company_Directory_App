import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetxController {
  var favorites = <int>[].obs;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('favorites') ?? [];
    favorites.value = saved.map((numString) => int.parse(numString)).toList();
  }

  Future<void> toggleFavorite(int companyId) async {
    final prefs = await SharedPreferences.getInstance();

    if (favorites.contains(companyId)) {
      favorites.remove(companyId);
    } else {
      favorites.add(companyId);
    }
    final idsAsString = favorites.map((id) => id.toString()).toList();
    await prefs.setStringList('favorites', idsAsString);
  }

  bool isFavorite(int companyId) {
    return favorites.contains(companyId);
  }
}
