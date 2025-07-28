import 'package:final_project/features/ecommerce/data/models/products/product.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'product_api_service.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com/')
abstract class ProductApiService {
  factory ProductApiService(Dio dio) = _ProductApiService;

  @GET('/products')
  Future<List<ProductModel>> getProducts();

  @GET('/products/categories')
  Future<List<String>> getCategories();
}
