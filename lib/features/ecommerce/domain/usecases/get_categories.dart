import 'package:dartz/dartz.dart';
import 'package:final_project/core/error/failure.dart';
import 'package:final_project/features/ecommerce/data/usecases/usecase.dart';
import 'package:final_project/features/ecommerce/domain/repository/products/product_repository.dart';

class GetCategories implements UseCase<List<String>, NoParams> {
  final ProductRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
