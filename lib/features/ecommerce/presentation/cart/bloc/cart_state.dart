import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, this.quantity = 1});

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => product.price * quantity;
}

class CartState {
  final List<CartItem> cartItems;
  final double totalPrice;

  CartState({this.cartItems = const [], this.totalPrice = 0.0});

  CartState copyWith({List<CartItem>? cartItems, double? totalPrice}) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  int get totalItemCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);
}
