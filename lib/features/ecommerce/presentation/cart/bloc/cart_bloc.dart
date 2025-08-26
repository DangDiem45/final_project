import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_event.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedCart = List<CartItem>.from(state.cartItems);
    final existingIndex = updatedCart.indexWhere(
      (item) => item.product.id == event.product.id,
    );
    if (existingIndex >= 0) {
      updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
        quantity: updatedCart[existingIndex].quantity + 1,
      );
    } else {
      updatedCart.add(CartItem(product: event.product, quantity: 1));
    }
    final total = updatedCart.fold(0.0, (sum, item) => sum + item.totalPrice);
    emit(state.copyWith(cartItems: updatedCart, totalPrice: total));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedCart = List<CartItem>.from(state.cartItems)
      ..removeWhere((item) => item.product.id == event.product.id);
    final total = updatedCart.fold(0.0, (sum, item) => sum + item.totalPrice);
    emit(state.copyWith(cartItems: updatedCart, totalPrice: total));
  }

  void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    final updatedCart = List<CartItem>.from(state.cartItems);
    final index = updatedCart.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (index >= 0) {
      updatedCart[index] = updatedCart[index].copyWith(
        quantity: updatedCart[index].quantity + 1,
      );
      final total = updatedCart.fold(0.0, (sum, item) => sum + item.totalPrice);
      emit(state.copyWith(cartItems: updatedCart, totalPrice: total));
    }
  }

  void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    final updatedCart = List<CartItem>.from(state.cartItems);
    final index = updatedCart.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (index >= 0) {
      if (updatedCart[index].quantity > 1) {
        updatedCart[index] = updatedCart[index].copyWith(
          quantity: updatedCart[index].quantity - 1,
        );
      }
      final total = updatedCart.fold(0.0, (sum, item) => sum + item.totalPrice);
      emit(state.copyWith(cartItems: updatedCart, totalPrice: total));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartState());
  }
}
