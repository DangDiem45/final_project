import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Product> products,
    @Default([]) List<String> categories,
    @Default('All') String selectedCategory,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingCategories,
    String? error,
  }) = _HomeState;
}
