part of 'menu_bloc.dart';

@immutable
sealed class MenuEvent {}

class GetRestaurantMenu extends MenuEvent {
  final num restaurantId;
  GetRestaurantMenu({required this.restaurantId});
}
