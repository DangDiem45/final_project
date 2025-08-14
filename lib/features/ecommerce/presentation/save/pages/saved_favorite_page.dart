import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/save/widgets/empty_favorite_widget.dart';
import 'package:final_project/features/ecommerce/presentation/save/widgets/product_grid_widget.dart';
import 'package:go_router/go_router.dart';

class SavedFavoritePage extends StatelessWidget {
  const SavedFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Items',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: BlocBuilder<SavedBloc, SavedState>(
        builder: (context, state) {
          return state.favorite.isEmpty
              ? const EmptyFavoriteWidget()
              : const Padding(
                  padding: EdgeInsets.all(16),
                  child: ProductGridWidget(),
                );
        },
      ),
    );
  }
}
