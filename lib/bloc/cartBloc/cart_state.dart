part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartSuccess extends CartState {
  final String message;
  CartSuccess(this.message);
}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItemModel> cart;
  final num totalAmount;

  CartLoaded({required this.cart, required this.totalAmount});
}

final class CartFailure extends CartState {
  final String error;
  CartFailure(this.error);
}
