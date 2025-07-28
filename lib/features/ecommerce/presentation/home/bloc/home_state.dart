import 'package:equatable/equatable.dart';
import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

class HomeState extends Equatable {
  final List<Product> products;
  final List<String> categories;
  final bool isLoading;
  final bool isLoadingCategories;
  final String? error;

  const HomeState({
    this.products = const [],
    this.categories = const [],
    this.isLoading = false,
    this.isLoadingCategories = false,
    this.error,
  });

  HomeState copyWith({
    List<Product>? products,
    List<String>? categories,
    bool? isLoading,
    bool? isLoadingCategories,
    String? error,
  }) {
    return HomeState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    products,
    categories,
    isLoading,
    isLoadingCategories,
    error,
  ];
}
