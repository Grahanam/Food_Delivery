import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/models/cart_item_model.dart';
import 'package:food_delivery/models/item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_addToCart);
    on<EmptyCart>(_emptyCart);
    on<UpdateCartItemQuantity>(_updateCartItemQuantity);
    on<RemoveFromCart>(_removeFromCart);
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) {
    final newItem = event.item;
    CartItemModel item = CartItemModel(
      item: event.item,
      price: newItem.itemPrice,
    );

    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      // bool found = false;

      List<CartItemModel> currentCart = currentState.cart;
      for (final cartitem in currentCart) {
        if (newItem.itemId == cartitem.item.itemId) {
          emit(CartSuccess('${newItem.itemName} is already in your cart.'));

          return emit(
            CartLoaded(
              cart: [...currentCart],
              totalAmount: currentState.totalAmount,
            ),
          );
          // found = true;
          // cartitem.quantity++;
          // cartitem.price = newItem.itemPrice * cartitem.quantity;
        }
      }
      // if (found == false) {
      //   currentCart.add(item);
      // }
      currentCart.add(item);
      num totalAmount = 0;
      for (final cartitem in currentCart) {
        totalAmount += cartitem.price;
      }
      emit(CartSuccess('${newItem.itemName} has been added to your cart.'));
      return emit(CartLoaded(cart: [...currentCart], totalAmount: totalAmount));
    }

    List<CartItemModel> cart = [];
    cart.add(item);
    emit(CartSuccess('${newItem.itemName} has been added to your cart.'));
    return emit(CartLoaded(cart: cart, totalAmount: event.item.itemPrice));
  }

  void _emptyCart(EmptyCart event, Emitter<CartState> emit) {
    emit(CartLoading());
    emit(CartLoaded(cart: [], totalAmount: 0.0));
    return emit(CartInitial());
  }

  void _updateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final itemList = currentState.cart;
      num totalAmount = 0.0;
      for (final cartItem in itemList) {
        if (cartItem.cartItemId == event.cartItemId) {
          cartItem.quantity = event.newQuantity;
        }
        cartItem.price = cartItem.quantity * cartItem.item.itemPrice;
        totalAmount += cartItem.price;
      }
      return emit(CartLoaded(cart: itemList, totalAmount: totalAmount));
    }
  }

  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedCart = currentState.cart
          .where((item) => item.cartItemId != event.cartItem.cartItemId)
          .toList();
      num totalAmount = 0.0;
      for (final cartItem in updatedCart) {
        cartItem.price = cartItem.quantity * cartItem.item.itemPrice;
        totalAmount += cartItem.price;
      }

      emit(CartSuccess('${event.cartItem.item.itemName} is removed !'));

      return emit(CartLoaded(cart: updatedCart, totalAmount: totalAmount));
    }
  }
}
