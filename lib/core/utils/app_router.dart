import 'package:final_project/core/di/injection_container.dart';
import 'package:final_project/features/ecommerce/domain/entities/products/product.dart';
import 'package:final_project/features/ecommerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/cart/pages/my_cart_page.dart';
import 'package:final_project/features/ecommerce/presentation/checkout/pages/checkout_page.dart';
import 'package:final_project/features/ecommerce/presentation/details/pages/product_detail_page.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/home/pages/home_page.dart';
import 'package:final_project/features/ecommerce/presentation/save/bloc/saved_bloc.dart';
import 'package:final_project/features/ecommerce/presentation/save/pages/saved_favorite_page.dart';
import 'package:final_project/features/ecommerce/presentation/search/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => sl<HomeBloc>(),
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        final query = state.uri.queryParameters['q'] ?? '';
        return SearchPage(initialQuery: query);
      },
    ),
    GoRoute(
      path: '/saved',
      builder: (context, state) => BlocProvider.value(
        value: sl<SavedBloc>(),
        child: SavedFavoritePage(),
      ),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) =>
          BlocProvider.value(value: sl<CartBloc>(), child: MyCartPage()),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) =>
          BlocProvider.value(value: sl<CartBloc>(), child: CheckoutPage()),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final product = state.extra as Product;
        return ProductDetailPage(product: product);
      },
    ),
  ],
);
