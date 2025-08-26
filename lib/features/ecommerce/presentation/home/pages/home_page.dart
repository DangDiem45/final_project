import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_event.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_state.dart';
import 'package:final_project/features/ecommerce/presentation/home/widgets/category_chip.dart';
import 'package:final_project/features/ecommerce/presentation/home/widgets/product_card.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/search/bloc/search_event.dart';
import 'package:final_project/features/ecommerce/presentation/search/widgets/search_bar_widget.dart';
import 'package:final_project/features/ecommerce/presentation/search/widgets/suggestion_widget.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (_selectedIndex == 0) {
      context.read<HomeBloc>().add(LoadHome());
    }
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

  void _navigateToSearch(String query) {
    context.go('/search?q=$query');
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _searchController.text = suggestion;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/saved');
        break;
      case 3:
        context.go('/cart');
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Discover',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(RefreshHome());
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchBar(
                    controller: _searchController,
                    onChanged: (value) => _performSearch(
                      context.read<SearchBloc>(),
                      value,
                      state.products,
                    ),
                    onSubmitted: (value) {
                      _addToRecentSearch(context.read<SearchBloc>(), value);
                      _navigateToSearch(value);
                    },
                    onClear: () => _clearSearch(context.read<SearchBloc>()),
                  ),
                  Suggestions(onSuggestionSelected: _onSuggestionSelected),
                  Gap(10),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return CategoryChip(
                          label: category,
                          isSelected: category == state.selectedCategory,
                          onTap: () {
                            context.read<HomeBloc>().add(
                              LoadProductsByCategory(category),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Gap(20),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state.error != null)
                    Center(
                      child: Column(
                        children: [
                          Text('Error: ${state.error}'),
                          ElevatedButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(RefreshHome());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(product: product);
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
