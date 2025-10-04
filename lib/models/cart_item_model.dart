import 'dart:convert';
import 'dart:math';

import 'package:food_delivery/models/item_model.dart';

class CartItemModel {
  final String cartItemId;
  final ItemModel item;
  num price;
  int quantity;
  CartItemModel({
    String? cartItemId,
    required this.item,
    this.price = 0.0,
    this.quantity = 1,
  }) : cartItemId =
           cartItemId ??
           '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(9999)}';

  CartItemModel copyWith({String? cartItemId, ItemModel? item, int? quantity}) {
    return CartItemModel(
      cartItemId: cartItemId ?? this.cartItemId,
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartItemId': cartItemId,
      'item': item.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      cartItemId: map['cartItemId'] as String,
      item: ItemModel.fromMap(map['item'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CartItemModel(cartItemId: $cartItemId, item: $item, quantity: $quantity)';

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;

    return other.cartItemId == cartItemId &&
        other.item == item &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => cartItemId.hashCode ^ item.hashCode ^ quantity.hashCode;
}
