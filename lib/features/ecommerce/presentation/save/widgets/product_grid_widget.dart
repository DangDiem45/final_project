import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/save/widgets/product_card_widget.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedBloc, SavedState>(
      builder: (context, state) {
        return GridView.builder(
          itemCount: state.favorite.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final product = state.favorite[index];
            return ProductCardWidget(product: product);
          },
        );
      },
    );
  }
}
