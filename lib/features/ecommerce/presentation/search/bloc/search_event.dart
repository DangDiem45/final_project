import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

abstract class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String query;
  final List<Product> allProducts;

  PerformSearch(this.query, this.allProducts);
}

class ClearSearch extends SearchEvent {}

class AddRecentSearch extends SearchEvent {
  final String search;

  AddRecentSearch(this.search);
}

class RemoveRecentSearch extends SearchEvent {
  final String search;

  RemoveRecentSearch(this.search);
}
