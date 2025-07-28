import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/presentation/details/pages/product_detail_page.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_event.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedBloc, SavedState>(
      builder: (context, state) {
        final isFavorite = state.favorite.any((p) => p.id == product.id);
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(product.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            final savedBloc = context.read<SavedBloc>();
                            if (isFavorite) {
                              savedBloc.add(
                                RemoveFromFavorites(
                                  product.copyWith(isFavorite: false),
                                ),
                              );
                              savedBloc.add(LoadSavedFavorites());
                            } else {
                              savedBloc.add(
                                AddToFavorites(
                                  product.copyWith(isFavorite: true),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
