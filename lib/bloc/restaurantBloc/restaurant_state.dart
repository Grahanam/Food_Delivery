part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object?> get props => [];
}

final class RestaurantInitial extends RestaurantState {}

final class RestaurantSuccess extends RestaurantState {
  final List data;
  final num? selectedRestaurantId;

  const RestaurantSuccess({required this.data, this.selectedRestaurantId});
}

final class RestaurantFailure extends RestaurantState {
  final String error;

  const RestaurantFailure(this.error);
}

final class RestaurantLoading extends RestaurantState {}
