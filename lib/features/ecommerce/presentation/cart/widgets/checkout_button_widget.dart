import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutButtonWidget extends StatelessWidget {
  final CartState state;

  const CheckoutButtonWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: state.cartItems.isEmpty
              ? null
              : () {
                  context.go('/checkout');
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Go To Checkout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
