import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_delivery/bloc/restaurantBloc/restaurant_bloc.dart';
import 'package:food_delivery/models/restaurant_model.dart';

import '../mocks/mock_restaurant_repository.dart';

void main() {
  late MockRestaurantRepository mockRepo;
  late RestaurantBloc restaurantBloc;

  final mockRestaurants = [
    RestaurantModel(
      restaurantId: 26,
      restaurantName: "1135 AD",
      address: "Jaipur, Amber Fort, Rajasthan",
      type: "Rajasthani",
      parkingLot: true,
    ),
    RestaurantModel(
      restaurantId: 25,
      restaurantName: "6 Ballygunge Place",
      address: "Kolkata, Ballygunge, West Bengal",
      type: "Bengali Cuisine",
      parkingLot: true,
    ),
  ];

  setUp(() {
    mockRepo = MockRestaurantRepository();
    restaurantBloc = RestaurantBloc(mockRepo);
  });

  tearDown(() {
    restaurantBloc.close();
  });

  group('RestaurantBloc - Simple Tests', () {
    test('initial state should be RestaurantInitial', () {
      expect(restaurantBloc.state, RestaurantInitial());
    });

    blocTest(
      'should emit Loading then Success when fetch succeeds',
      build: () {
        when(
          () => mockRepo.getRestaurants(),
        ).thenAnswer((_) async => mockRestaurants);
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(RestaurantFetched()),
      expect: () => [
        RestaurantLoading(),
        RestaurantSuccess(data: mockRestaurants),
      ],
    );

    blocTest(
      'should emit Loading then Failure when fetch fails',
      build: () {
        when(
          () => mockRepo.getRestaurants(),
        ).thenThrow(Exception('Network error'));
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(RestaurantFetched()),
      expect: () => [
        RestaurantLoading(),
        RestaurantFailure('Exception: Network error'),
      ],
    );

    blocTest(
      'should do nothing when SelectRestaurant is added to non-Success state',
      build: () => restaurantBloc,
      seed: () => RestaurantInitial(),
      act: (bloc) => bloc.add(SelectRestaurant(restaurantId: 1)),
      expect: () => [],
    );
  });
}
