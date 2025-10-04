import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:food_delivery/models/cart_item_model.dart';

class OrderModel {
  final String orderId;
  final List<CartItemModel> items;
  final num totalAmount;
  final num subTotal;
  final num tax;
  final num deliveryFee;
  final DateTime orderDate;

  OrderModel({
    String? orderId,
    required this.items,
    required this.totalAmount,
    required this.subTotal,
    required this.tax,
    required this.deliveryFee,
    required this.orderDate,
  }) : orderId =
           orderId ??
           '${DateTime.now().microsecondsSinceEpoch}-${Random().nextInt(9999)}';

  OrderModel copyWith({
    String? orderId,
    List<CartItemModel>? items,
    num? totalAmount,
    num? subTotal,
    num? tax,
    num? deliveryFee,
    DateTime? orderDate,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      subTotal: subTotal ?? this.subTotal,
      tax: tax ?? this.tax,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'items': items.map((x) => x.toMap()).toList(),
      'totalAmount': totalAmount,
      'subTotal': subTotal,
      'tax': tax,
      'deliveryFee': deliveryFee,
      'orderDate': orderDate.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      items: List<CartItemModel>.from(
        (map['items'] as List<int>).map<CartItemModel>(
          (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalAmount: map['totalAmount'] as num,
      subTotal: map['subTotal'] as num,
      tax: map['tax'] as num,
      deliveryFee: map['deliveryFee'] as num,
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, items: $items, totalAmount: $totalAmount, subTotal: $subTotal, tax: $tax, deliveryFee: $deliveryFee, orderDate: $orderDate)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        listEquals(other.items, items) &&
        other.totalAmount == totalAmount &&
        other.subTotal == subTotal &&
        other.tax == tax &&
        other.deliveryFee == deliveryFee &&
        other.orderDate == orderDate;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        items.hashCode ^
        totalAmount.hashCode ^
        subTotal.hashCode ^
        tax.hashCode ^
        deliveryFee.hashCode ^
        orderDate.hashCode;
  }
}
