import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/presentation/home/widgets/product_card.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  final List<Product> searchResults;

  const SearchResults({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ProductCard(product: searchResults[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
