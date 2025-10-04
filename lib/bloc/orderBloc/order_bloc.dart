import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery/models/cart_item_model.dart';
import 'package:food_delivery/models/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<PlaceOrder>(_placeOrder);
  }

  void _placeOrder(PlaceOrder event, Emitter<OrderState> emit) {
    List<OrderModel> orders = [];
    final newOrder = OrderModel(
      items: event.items,
      totalAmount: event.totalAmount,
      subTotal: event.subTotal,
      tax: event.tax,
      deliveryFee: event.deliveryFee,
      orderDate: DateTime.now(),
    );
    if (state is OrderLoaded) {
      final currentState = state as OrderLoaded;
      orders = [...currentState.orders];
    }
    return emit(OrderLoaded(orders: [...orders, newOrder]));
  }
}
