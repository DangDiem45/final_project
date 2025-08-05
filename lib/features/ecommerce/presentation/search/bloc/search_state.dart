import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';

class SearchState {
  final String? query;
  final List<Product>? searchResults;
  final List<String>? recentSearches;
  final bool? isSearching;
  final List<String>? suggestions;

  SearchState({
    this.query,
    this.searchResults,
    this.recentSearches,
    this.isSearching,
    this.suggestions,
  });

  SearchState.initial()
    : query = '',
      searchResults = [],
      recentSearches = [],
      isSearching = false,
      suggestions = [];

  SearchState copyWith({
    String? query,
    List<Product>? searchResults,
    List<String>? recentSearches,
    bool? isSearching,
    List<String>? suggestions,
  }) {
    return SearchState(
      query: query ?? this.query,
      searchResults: searchResults ?? this.searchResults,
      recentSearches: recentSearches ?? this.recentSearches,
      isSearching: isSearching ?? this.isSearching,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}
