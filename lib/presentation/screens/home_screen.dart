import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/restaurantBloc/restaurant_bloc.dart';
import 'package:food_delivery/presentation/screens/restaurant_menu_screen.dart';
import 'package:food_delivery/presentation/widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantBloc>().add(RestaurantFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurants')),
      body: BlocConsumer<RestaurantBloc, RestaurantState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RestaurantSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final restaurant = state.data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RestaurantCard(
                    restaurant: restaurant,
                    isSelected:
                        state.selectedRestaurantId == restaurant.restaurantId,
                    onTap: () => {
                      context.read<RestaurantBloc>().add(
                        SelectRestaurant(restaurantId: restaurant.restaurantId),
                      ),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RestaurantMenuScreen(restaurant: restaurant),
                        ),
                      ),
                    },
                  ),
                );
              },
            );
          }

          return Text('Restaurant App');
        },
      ),
    );
  }
}
