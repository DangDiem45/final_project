import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:final_project/features/ecommerce/presentation/cart/widgets/summary_row_widget.dart';
import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  final CartState state;

  const OrderSummaryWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final subtotal = state.totalPrice;
    const vat = 0.00;
    const shippingFee = 80.0;
    final total = subtotal + vat + shippingFee;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SummaryRowWidget(
            label: 'Sub-total',
            value: '\$ ${subtotal.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 12),
          SummaryRowWidget(
            label: 'VAT (%)',
            value: '\$ ${vat.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          SummaryRowWidget(
            label: 'Shipping fee',
            value: '\$ ${shippingFee.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: Colors.grey[200]),
          const SizedBox(height: 16),
          SummaryRowWidget(
            label: 'Total',
            value: '\$ ${total.toStringAsFixed(0)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}
