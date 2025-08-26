import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

abstract class SavedEvent {}

class LoadSavedFavorites extends SavedEvent {}

class AddToFavorites extends SavedEvent {
  final Product products;
  AddToFavorites(this.products);
}

class RemoveFromFavorites extends SavedEvent {
  final Product products;
  RemoveFromFavorites(this.products);
}
