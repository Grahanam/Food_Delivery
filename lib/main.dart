import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/cartBloc/cart_bloc.dart';
import 'package:food_delivery/bloc/menuBloc/menu_bloc.dart';
import 'package:food_delivery/bloc/orderBloc/order_bloc.dart';
import 'package:food_delivery/bloc/restaurantBloc/restaurant_bloc.dart';

import 'package:food_delivery/data/data_provider/restaurant_data_provider.dart';

import 'package:food_delivery/data/repository/restaurant_repository.dart';
import 'package:food_delivery/presentation/layout/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RestaurantRepository(RestaurantDataProvider()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                RestaurantBloc(context.read<RestaurantRepository>()),
          ),
          BlocProvider(
            create: (context) => MenuBloc(context.read<RestaurantRepository>()),
          ),
          BlocProvider(create: (_) => OrderBloc()),
          BlocProvider(create: (_) => CartBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const MainLayout(index: 0,),
        ),
      ),
    );
  }
}
