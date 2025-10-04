import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/cartBloc/cart_bloc.dart';
import 'package:food_delivery/bloc/menuBloc/menu_bloc.dart';

import 'package:food_delivery/models/restaurant_model.dart';
import 'package:food_delivery/presentation/layout/main_layout.dart';
import 'package:food_delivery/presentation/widgets/item_card.dart';

class RestaurantMenuScreen extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantMenuScreen({super.key, required this.restaurant});

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MenuBloc>().add(
      GetRestaurantMenu(restaurantId: widget.restaurant.restaurantId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurant.restaurantName)),
      body: BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MenuLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MenuSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final menuItem = state.data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ItemCard(
                    item: menuItem,
                    onTap: () => {
                      context.read<CartBloc>().add(AddToCart(item: menuItem)),
                    },
                    isSelected: false,
                  ),
                );
              },
            );
          }
          return Text('menu List');
        },
      ),
      floatingActionButton: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainLayout(index: 2)),
              ),
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_rounded),
                Positioned(
                  top: -16,
                  right: -8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      state is CartLoaded ? '${state.cart.length}' : '0',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
