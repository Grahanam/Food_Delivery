part of 'restaurant_bloc.dart';

@immutable
sealed class RestaurantEvent {}

final class RestaurantFetched extends RestaurantEvent {}

final class SelectRestaurant extends RestaurantEvent {
  final num restaurantId;

  SelectRestaurant({required this.restaurantId});
}
