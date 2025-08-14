import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

abstract class SavedFavoriteRepository {
  Future<List<Product>> getFavorites();
  Future<void> savedFavorites(List<Product> favorites);
}
