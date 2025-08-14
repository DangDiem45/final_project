import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  final CartState state;
  final bool isPromoApplied;
  final double promoDiscount;

  const OrderSummaryWidget({
    super.key,
    required this.state,
    required this.isPromoApplied,
    required this.promoDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final subtotal = state.totalPrice;
    const vat = 0.00;
    const shippingFee = 80.0;
    final discount = isPromoApplied ? promoDiscount : 0.0;
    final total = subtotal + vat + shippingFee - discount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        _buildSummaryRow('Sub-total', '\$ ${subtotal.toStringAsFixed(0)}'),
        const SizedBox(height: 12),
        _buildSummaryRow('VAT (%)', '\$ ${vat.toStringAsFixed(2)}'),
        const SizedBox(height: 12),
        _buildSummaryRow(
          'Shipping fee',
          '\$ ${shippingFee.toStringAsFixed(0)}',
        ),
        if (isPromoApplied) ...[
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Discount',
            '- \$ ${discount.toStringAsFixed(0)}',
            isDiscount: true,
          ),
        ],
        const SizedBox(height: 16),
        Container(height: 1, color: Colors.grey[200]),
        const SizedBox(height: 16),
        _buildSummaryRow(
          'Total',
          '\$ ${total.toStringAsFixed(0)}',
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: FontWeight.w600,
            color: isDiscount ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
