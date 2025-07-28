import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/core/error/failure.dart';
import 'package:final_project/features/ecommerce/data/usecases/usecase.dart';
import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/domain/repository/products/product_repository.dart';

class GetProductsByCategory implements UseCase<List<Product>, CategoryParams> {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(CategoryParams params) async {
    return await repository.getProductsByCategory(params.category);
  }
}

class CategoryParams extends Equatable {
  final String category;

  const CategoryParams({required this.category});

  @override
  List<Object> get props => [category];
}
