import 'package:final_project/core/error/failure.dart';
import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<String>>> getCategories();
}
