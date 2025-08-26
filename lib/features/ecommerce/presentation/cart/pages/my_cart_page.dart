import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_event.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:final_project/features/ecommerce/presentation/cart/widgets/cart_empty_widget.dart';
import 'package:final_project/features/ecommerce/presentation/cart/widgets/cart_item_widget.dart';
import 'package:final_project/features/ecommerce/presentation/cart/widgets/checkout_button_widget.dart';
import 'package:final_project/features/ecommerce/presentation/cart/widgets/order_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const CartEmptyWidget();
          }
          return _buildCartWithItems(context, state);
        },
      ),
    );
  }

  Widget _buildCartWithItems(BuildContext context, CartState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = state.cartItems[index];
              return CartItemWidget(
                cartItem: cartItem,
                index: index,
                onRemove: () {
                  print('Removing product: ${cartItem.product.title}');
                  context.read<CartBloc>().add(
                    RemoveFromCart(cartItem.product),
                  );
                },
              );
            },
          ),
        ),
        OrderSummaryWidget(state: state),
        CheckoutButtonWidget(state: state),
      ],
    );
  }
}
