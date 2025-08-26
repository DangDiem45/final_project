import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:flutter/material.dart';

class PlaceOrderButtonWidget extends StatelessWidget {
  final CartState state;
  final VoidCallback onPlaceOrder;

  const PlaceOrderButtonWidget({
    super.key,
    required this.state,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.cartItems.isEmpty ? null : onPlaceOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Place Order',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
