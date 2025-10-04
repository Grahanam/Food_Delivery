import 'dart:convert';

class RestaurantModel {
  final num restaurantId;
  final String restaurantName;
  final String address;
  final String type;
  final bool parkingLot;

  RestaurantModel({
    required this.restaurantId,
    required this.restaurantName,
    required this.address,
    required this.type,
    required this.parkingLot,
  });

  RestaurantModel copyWith({
    num? restaurantId,
    String? restaurantName,
    String? address,
    String? type,
    bool? parkingLot,
  }) {
    return RestaurantModel(
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      address: address ?? this.address,
      type: type ?? this.type,
      parkingLot: parkingLot ?? this.parkingLot,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'address': address,
      'type': type,
      'parkingLot': parkingLot,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      restaurantId: map['restaurantId'] as num,
      restaurantName: map['restaurantName'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      parkingLot: map['parkingLot'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromJson(String source) =>
      RestaurantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RestaurantModel(restaurantId: $restaurantId, restaurantName: $restaurantName, address: $address, type: $type, parkingLot: $parkingLot)';
  }

  @override
  bool operator ==(covariant RestaurantModel other) {
    if (identical(this, other)) return true;

    return other.restaurantId == restaurantId &&
        other.restaurantName == restaurantName &&
        other.address == address &&
        other.type == type &&
        other.parkingLot == parkingLot;
  }

  @override
  int get hashCode {
    return restaurantId.hashCode ^
        restaurantName.hashCode ^
        address.hashCode ^
        type.hashCode ^
        parkingLot.hashCode;
  }
}
