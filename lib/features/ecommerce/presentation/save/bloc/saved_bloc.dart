import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/domain/repository/products/saved_favorite_repository.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_event.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final SavedFavoriteRepository repository;
  SavedBloc(this.repository) : super(const SavedState()) {
    on<LoadSavedFavorites>(_onLoadSavedFavorites);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);

    add(LoadSavedFavorites());
  }

  Future<void> _onLoadSavedFavorites(
    LoadSavedFavorites event,
    Emitter<SavedState> emit,
  ) async {
    final favorites = await repository.getFavorites();
    emit(SavedState(favorite: favorites));
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<SavedState> emit,
  ) async {
    final product = event.products.copyWith(isFavorite: true);
    final updatedFavorites = List<Product>.from(state.favorite)..add(product);
    await repository.savedFavorites(updatedFavorites);
    emit(SavedState(favorite: updatedFavorites));
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<SavedState> emit,
  ) async {
    final productToRemove = event.products.copyWith(isFavorite: false);
    final updatedFavorites = List<Product>.from(state.favorite)
      ..removeWhere((p) => p.id == productToRemove.id);

    await repository.savedFavorites(updatedFavorites);
    emit(SavedState(favorite: updatedFavorites));
  }
}
