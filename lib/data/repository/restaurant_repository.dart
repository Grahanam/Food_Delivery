import 'dart:convert';

import 'package:food_delivery/data/data_provider/restaurant_data_provider.dart';
import 'package:food_delivery/models/item_model.dart';
import 'package:food_delivery/models/restaurant_model.dart';

class RestaurantRepository {
  final RestaurantDataProvider restaurantDataProvider;
  RestaurantRepository(this.restaurantDataProvider);

  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      String cityName = 'New Delhi';
      final restaurantData = await restaurantDataProvider.getRestaurants(
        cityName,
      );

      final data = jsonDecode(restaurantData);

      if (data is! List) {
        throw 'An unexpected error occurred';
      }
      return data.map<RestaurantModel>((e) {
        return RestaurantModel.fromMap({
          'restaurantId': e['restaurantID'],
          'restaurantName': e['restaurantName'],
          'address': e['address'],
          'type': e['type'],
          'parkingLot': e['parkingLot'],
        });
      }).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ItemModel>> getMenu(num restaurantId) async {
    try {
      final restaurantData = await restaurantDataProvider.getMenu(restaurantId);

      final data = jsonDecode(restaurantData);
      if (data is! List) {
        throw 'An unexpected error occurred';
      }
      return data.map<ItemModel>((e) {
        return ItemModel.fromMap({
          'itemId': e['itemID'],
          'itemName': e['itemName'],
          'restaurantId': e['restaurantID'],
          'restaurantName': e['restaurantName'],
          'itemDescription': e['itemDescription'],
          'itemPrice': e['itemPrice'],
          'imageUrl': e['imageUrl'],
        });
      }).toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
