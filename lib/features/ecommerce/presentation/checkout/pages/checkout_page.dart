import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_event.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:final_project/features/ecommerce/presentation/checkout/widgets/order_summary_widget.dart';
import 'package:final_project/features/ecommerce/presentation/checkout/widgets/delivery_address_widget.dart';
import 'package:final_project/features/ecommerce/presentation/checkout/widgets/payment_method_widget.dart';
import 'package:final_project/features/ecommerce/presentation/checkout/widgets/place_order_button_widget.dart';
import 'package:final_project/features/ecommerce/presentation/checkout/widgets/promo_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPaymentMethod = 'Card';
  final TextEditingController promoController = TextEditingController();
  bool isPromoApplied = false;
  double promoDiscount = 0.0;

  @override
  void dispose() {
    promoController.dispose();
    super.dispose();
  }

  void applyPromoCode() {
    final promoCode = promoController.text.trim().toUpperCase();

    if (promoCode.isEmpty) {
      _showMessage('Please enter a promo code');
      return;
    }

    const promoCodes = {'SAVE10': 10.0, 'DISCOUNT20': 20.0, 'WELCOME': 15.0};

    if (promoCodes.containsKey(promoCode)) {
      setState(() {
        isPromoApplied = true;
        promoDiscount = promoCodes[promoCode]!;
      });
      _showMessage('Promo code applied successfully!');
    } else {
      _showMessage('Invalid promo code');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 24),
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your order has been placed and will be delivered soon.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(ClearCart());
                  context.go('/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go("/cart"),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryAddressWidget(),
                  const SizedBox(height: 24),
                  PaymentMethodWidget(
                    selectedPaymentMethod: selectedPaymentMethod,
                    onPaymentMethodChanged: (method) {
                      setState(() {
                        selectedPaymentMethod = method;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  OrderSummaryWidget(
                    state: state,
                    isPromoApplied: isPromoApplied,
                    promoDiscount: promoDiscount,
                  ),
                  const SizedBox(height: 24),
                  PromoCodeWidget(
                    controller: promoController,
                    onApplyPromo: applyPromoCode,
                  ),
                  const Spacer(),
                  PlaceOrderButtonWidget(
                    state: state,
                    onPlaceOrder: _showOrderSuccessDialog,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
