import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/data/repository/restaurant_repository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final RestaurantRepository restaurantRepository;
  MenuBloc(this.restaurantRepository) : super(MenuInitial()) {
    on<GetRestaurantMenu>(_getRestauranttMenu);
  }

  void _getRestauranttMenu(
    GetRestaurantMenu event,
    Emitter<MenuState> emit,
  ) async {
    emit(MenuLoading());
    try {
      final List menu = await restaurantRepository.getMenu(event.restaurantId);
      return emit(MenuSuccess(data: menu));
    } catch (e) {
      return emit(MenuFailure(e.toString()));
    }
  }
}
