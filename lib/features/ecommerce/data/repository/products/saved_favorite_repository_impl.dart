import 'package:final_project/core/di/injection_container.dart';
import 'package:final_project/features/ecommerce/data/models/products/product.dart';
import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/domain/repository/products/saved_favorite_repository.dart';

class SavedFavoriteRepositoryImpl implements SavedFavoriteRepository {
  final SavedLocalDataSource dataSource;

  SavedFavoriteRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getFavorites() async {
    final favoritesModel = await dataSource.getFavorites();
    return favoritesModel.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> savedFavorites(List<Product> favorites) async {
    final favoritesModel = favorites
        .map(
          (product) => ProductModel(
            id: product.id,
            title: product.title,
            price: product.price,
            description: product.description,
            category: product.category,
            image: product.image,
            rating: RatingModel(
              rate: product.rating.rate,
              count: product.rating.count,
            ),
            isFavorite: product.isFavorite,
          ),
        )
        .toList();
    await dataSource.savedFavorites(favoritesModel);
  }
}
