import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_project/core/error/failure.dart';
import 'package:final_project/features/ecommerce/data/datasource/products/product_api_service.dart';
import 'package:final_project/features/ecommerce/data/models/products/product.dart';
import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/domain/repository/products/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService apiService;

  ProductRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final result = await apiService.getProducts();
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final result = await apiService.getCategories();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
