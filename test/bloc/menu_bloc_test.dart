import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:food_delivery/bloc/menuBloc/menu_bloc.dart';
import 'package:food_delivery/models/item_model.dart';
import '../mocks/mock_restaurant_repository.dart';

void main() {
  late MockRestaurantRepository mockRepo;
  late MenuBloc menuBloc;

  final mockMenu = [
    ItemModel(
      itemId: 70,
      itemName: "Laal Maas",
      itemDescription: "Spicy Rajasthani mutton curry made with red chilies.",
      itemPrice: 500.00,
      restaurantName: "1135 AD",
      restaurantId: 26,
      imageUrl: "https://fakerestaurantapi.runasp.net/images/laal-maas.jpeg",
    ),
    ItemModel(
      itemId: 71,
      itemName: "Dal Baati Churma",
      itemDescription:
          "Traditional Rajasthani dish with wheat dumplings, dal, and sweet churma.",
      itemPrice: 350.00,
      restaurantName: "1135 AD",
      restaurantId: 26,
      imageUrl:
          "https://fakerestaurantapi.runasp.net/images/dal%20bati%20churma.jpg",
    ),
    ItemModel(
      itemId: 72,
      itemName: "Ghevar",
      itemDescription:
          "Sweet Rajasthani dessert made with flour, ghee, and sugar syrup.",
      itemPrice: 180.00,
      restaurantName: "1135 AD",
      restaurantId: 26,
      imageUrl: "https://fakerestaurantapi.runasp.net/images/ghevar.jpg",
    ),
  ];

  setUp(() {
    mockRepo = MockRestaurantRepository();
    menuBloc = MenuBloc(mockRepo);
  });

  tearDown(() {
    menuBloc.close();
  });

  group('MenuBloc - Simple Tests', () {
    test('initial state should be MenuInitial', () {
      expect(menuBloc.state, MenuInitial());
    });

    blocTest(
      'should emit Loading then Success when getMenu succeeds',
      build: () {
        when(() => mockRepo.getMenu(26)).thenAnswer((_) async => mockMenu);
        return menuBloc;
      },
      act: (bloc) => bloc.add(GetRestaurantMenu(restaurantId: 26)),
      expect: () => [MenuLoading(), MenuSuccess(data: mockMenu)],
    );

    blocTest(
      'should emit Loading then Failure when getMenu fails',
      build: () {
        when(() => mockRepo.getMenu(1)).thenThrow(Exception('Menu not found'));
        return menuBloc;
      },
      act: (bloc) => bloc.add(GetRestaurantMenu(restaurantId: 1)),
      expect: () => [MenuLoading(), MenuFailure('Exception: Menu not found')],
    );
  });
}
