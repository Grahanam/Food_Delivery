import 'package:http/http.dart' as http;

class RestaurantDataProvider {
  Future<String> getRestaurants(String cityName) async {
    try {
      final res = await http.get(
        Uri.parse('https://fakerestaurantapi.runasp.net/api/Restaurant'),
      );
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> getMenu(num restaurantId) async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://fakerestaurantapi.runasp.net/api/Restaurant/${restaurantId}/menu',
        ),
      );
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
