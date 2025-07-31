import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

class CartState {
  final List<Product> cartItems;
  final double totalPrice;

  CartState({this.cartItems = const [], this.totalPrice = 0.0});

  CartState copyWith({List<Product>? cartItems, double? totalPrice}) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
