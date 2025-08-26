import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

class SavedState {
  final List<Product> favorite;
  const SavedState({this.favorite = const []});
  SavedState copyWith(List<Product>? favorite) {
    return SavedState(favorite: favorite ?? this.favorite);
  }
}
