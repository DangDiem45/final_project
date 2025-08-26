import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_project/core/network/dio_client.dart';
import 'package:final_project/features/ecommerce/data/datasource/products/product_api_service.dart';
import 'package:final_project/features/ecommerce/data/models/products/product.dart';
import 'package:final_project/features/ecommerce/data/repository/products/product_repository_impl.dart';
import 'package:final_project/features/ecommerce/data/repository/products/saved_favorite_repository_impl.dart';
import 'package:final_project/features/ecommerce/domain/repository/products/product_repository.dart';
import 'package:final_project/features/ecommerce/domain/repository/products/saved_favorite_repository.dart';
import 'package:final_project/features/ecommerce/domain/usecases/get_categories.dart';
import 'package:final_project/features/ecommerce/domain/usecases/get_product.dart';
import 'package:final_project/features/ecommerce/domain/usecases/get_products_by_category.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class SavedLocalDataSource {
  static const String _favoritesKey = 'favorites';
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<ProductModel>> getFavorites() async {
    final favoritesJson = _prefs.getStringList(_favoritesKey) ?? [];
    return favoritesJson
        .map((json) => ProductModel.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> savedFavorites(List<ProductModel> favorites) async {
    final favoritesJson = favorites
        .map((product) => jsonEncode(product.toJson()))
        .toList();
    await _prefs.setStringList(_favoritesKey, favoritesJson);
  }
}

Future<void> initializeDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() {
    final dataSource = SavedLocalDataSource();
    dataSource.init();
    return dataSource;
  });
  sl.registerLazySingleton<Dio>(() => DioClient.createDio());
  sl.registerLazySingleton<ProductApiService>(() => ProductApiService(sl()));
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<SavedFavoriteRepository>(
    () => SavedFavoriteRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetProduct(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetProductsByCategory(sl()));

  sl.registerFactory(
    () => HomeBloc(
      getProducts: sl(),
      getCategories: sl(),
      getProductsByCategory: sl(),
    ),
  );
  sl.registerFactory(() => SavedBloc(sl()));
}
