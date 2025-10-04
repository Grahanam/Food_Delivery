import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery/data/repository/restaurant_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository;
  RestaurantBloc(this.restaurantRepository) : super(RestaurantInitial()) {
    on<RestaurantFetched>(_getRestaurants);
    on<SelectRestaurant>(_onSelectRestaurant);
  }

  void _getRestaurants(
    RestaurantFetched event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    try {
      final List restaurant = await restaurantRepository.getRestaurants();
      return emit(RestaurantSuccess(data: restaurant));
    } catch (e) {
      return emit(RestaurantFailure(e.toString()));
    }
  }

  void _onSelectRestaurant(
    SelectRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    if (state is RestaurantSuccess) {
      final currentState = state as RestaurantSuccess;
      return emit(
        RestaurantSuccess(
          data: currentState.data,
          selectedRestaurantId: event.restaurantId,
        ),
      );
    }
    return;
  }

  @override
  void onChange(Change<RestaurantState> change) {
    super.onChange(change);
    debugPrint(change.toString());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint(error.toString());
  }
}
