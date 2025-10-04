part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class PlaceOrder extends OrderEvent {
  final List<CartItemModel> items;
  final num totalAmount;
  final num subTotal;
  final num deliveryFee;
  final num tax;

  PlaceOrder({
    required this.items,
    required this.totalAmount,
    required this.subTotal,
    required this.deliveryFee,
    required this.tax,
  });
}
