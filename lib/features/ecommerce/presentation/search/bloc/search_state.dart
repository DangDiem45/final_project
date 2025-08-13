import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

part 'search_state.freezed.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    String? query,
    List<Product>? searchResults,
    List<String>? recentSearches,
    bool? isSearching,
    List<String>? suggestions,
  }) = _SearchState;

  factory SearchState.initial() => const SearchState(
    query: '',
    searchResults: [],
    recentSearches: [],
    isSearching: false,
    suggestions: [],
  );
}
