import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_event.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:final_project/features/ecommerce/presentation/cart/widgets/quantity_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.index,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[100],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartItem.product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.grey[400],
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Size L',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$ ${cartItem.product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  QuantityButtonWidget(
                    icon: Icons.remove,
                    onTap: () {
                      context.read<CartBloc>().add(
                        DecreaseQuantity(cartItem.product),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${cartItem.quantity}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  QuantityButtonWidget(
                    icon: Icons.add,
                    onTap: () {
                      context.read<CartBloc>().add(
                        IncreaseQuantity(cartItem.product),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
