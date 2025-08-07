import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:final_project/features/ecommerce/presentation/cart/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class CartListWidget extends StatelessWidget {
  final CartState state;

  const CartListWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.cartItems.length,
        itemBuilder: (context, index) {
          final product = state.cartItems[index];
          return CartItemWidget(
            cartItem: product,
            index: index,
            onRemove: () {},
          );
        },
      ),
    );
  }
}
