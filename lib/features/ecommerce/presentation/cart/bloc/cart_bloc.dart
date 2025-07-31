import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_event.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedCart = List<Product>.from(state.cartItems)..add(event.product);
    final total = updatedCart.fold(0.0, (sum, item) => sum + item.price);
    emit(state.copyWith(cartItems: updatedCart, totalPrice: total));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedCart = List<Product>.from(state.cartItems)
      ..removeWhere((item) => item.id == event.product.id);
    final total = updatedCart.fold(0.0, (sum, item) => sum + item.price);
    emit(state.copyWith(cartItems: updatedCart, totalPrice: total));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartState());
  }
}
