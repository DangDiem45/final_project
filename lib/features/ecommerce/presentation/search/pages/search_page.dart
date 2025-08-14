import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_state.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_event.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_state.dart';
import 'package:final_project/features/ecommerce/presentation/search/widgets/no_result_widget.dart';
import 'package:final_project/features/ecommerce/presentation/search/widgets/recent_search_widget.dart';
import 'package:final_project/features/ecommerce/presentation/search/widgets/search_result_widget.dart';
import 'package:final_project/features/ecommerce/presentation/search/widgets/search_bar_widget.dart';
import 'package:final_project/features/ecommerce/presentation/search/widgets/suggestion_widget.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(
    SearchBloc searchBloc,
    String query,
    List<Product> allProducts,
  ) {
    searchBloc.add(PerformSearch(query, allProducts));
  }

  void _clearSearch(SearchBloc searchBloc) {
    _searchController.clear();
    searchBloc.add(ClearSearch());
  }

  void _addToRecentSearch(SearchBloc searchBloc, String search) {
    searchBloc.add(AddRecentSearch(search));
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _searchController.text = suggestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.read<SearchBloc>().add(ClearSearch());
            context.go('/');
          },
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (homeContext, homeState) {
          return BlocBuilder<SearchBloc, SearchState>(
            builder: (searchContext, searchState) {
              final query = searchState.query ?? '';
              final searchResults = searchState.searchResults ?? [];
              final recentSearches = searchState.recentSearches ?? [];
              return Column(
                children: [
                  SearchBar(
                    controller: _searchController,
                    onChanged: (value) => _performSearch(
                      searchContext.read<SearchBloc>(),
                      value,
                      homeState.products,
                    ),
                    onSubmitted: (value) {
                      _addToRecentSearch(
                        searchContext.read<SearchBloc>(),
                        value,
                      );
                      _performSearch(
                        searchContext.read<SearchBloc>(),
                        value,
                        homeState.products,
                      );
                    },
                    onClear: () =>
                        _clearSearch(searchContext.read<SearchBloc>()),
                  ),
                  Suggestions(onSuggestionSelected: _onSuggestionSelected),
                  Expanded(
                    child: query.isEmpty
                        ? RecentSearches(
                            recentSearches: recentSearches,
                            onRemove: (search) => searchContext
                                .read<SearchBloc>()
                                .add(RemoveRecentSearch(search)),
                            onTap: (search) {
                              _searchController.text = search;
                              _performSearch(
                                searchContext.read<SearchBloc>(),
                                search,
                                homeState.products,
                              );
                            },
                          )
                        : searchResults.isEmpty
                        ? const NoResults()
                        : SearchResults(
                            searchResults: searchState.searchResults!,
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
