import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/cartBloc/cart_bloc.dart';

import 'package:food_delivery/presentation/screens/cart_screen.dart';
import 'package:food_delivery/presentation/screens/home_screen.dart';
import 'package:food_delivery/presentation/screens/orders_screen.dart';

class MainLayout extends StatefulWidget {
  final int index;
  const MainLayout({super.key, required this.index});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const HomeScreen(),
    const OrderScreen(),
    const CartScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavbar(),
    );
  }

  Widget _buildIconBadge(IconData icon) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final int count = state is CartLoaded ? state.cart.length : 0;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon),
            if (count > 0)
              Positioned(
                top: -10,
                right: -8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Text(count.toString()),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavbar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long),
          label: 'Orders',
        ),

        BottomNavigationBarItem(
          icon: _buildIconBadge(Icons.shopping_cart_outlined),
          activeIcon: _buildIconBadge(Icons.shopping_cart),
          label: 'Cart',
        ),
      ],
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }
}
