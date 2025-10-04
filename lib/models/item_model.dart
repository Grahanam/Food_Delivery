import 'dart:convert';

class ItemModel {
  final num itemId;
  final String itemName;
  final String itemDescription;
  final num itemPrice;
  final String restaurantName;
  final num restaurantId;
  final String imageUrl;

  ItemModel({
    required this.itemId,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.restaurantName,
    required this.restaurantId,
    required this.imageUrl,
  });

  ItemModel copyWith({
    num? itemId,
    String? itemName,
    String? itemDescription,
    num? itemPrice,
    String? restaurantName,
    num? restaurantId,
    String? imageUrl,
  }) {
    return ItemModel(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      itemPrice: itemPrice ?? this.itemPrice,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantId: restaurantId ?? this.restaurantId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemPrice': itemPrice,
      'restaurantName': restaurantName,
      'restaurantId': restaurantId,
      'imageUrl': imageUrl,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      itemId: map['itemId'] as num,
      itemName: map['itemName'] as String,
      itemDescription: map['itemDescription'] as String,
      itemPrice: map['itemPrice'] as num,
      restaurantName: map['restaurantName'] as String,
      restaurantId: map['restaurantId'] as num,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(itemId: $itemId, itemName: $itemName, itemDescription: $itemDescription, itemPrice: $itemPrice, restaurantName: $restaurantName, restaurantId: $restaurantId, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.itemId == itemId &&
        other.itemName == itemName &&
        other.itemDescription == itemDescription &&
        other.itemPrice == itemPrice &&
        other.restaurantName == restaurantName &&
        other.restaurantId == restaurantId &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return itemId.hashCode ^
        itemName.hashCode ^
        itemDescription.hashCode ^
        itemPrice.hashCode ^
        restaurantName.hashCode ^
        restaurantId.hashCode ^
        imageUrl.hashCode;
  }
}
