part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCart extends CartEvent {
  final ItemModel item;

  AddToCart({required this.item});
}

class EmptyCart extends CartEvent {}

class UpdateCartItemQuantity extends CartEvent {
  final String cartItemId;
  final int newQuantity;

  UpdateCartItemQuantity({required this.cartItemId, required this.newQuantity});
}

class RemoveFromCart extends CartEvent {
  final CartItemModel cartItem;

  RemoveFromCart({required this.cartItem});
}
