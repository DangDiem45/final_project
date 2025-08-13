import 'package:final_project/features/ecommerce/presentation/home/pages/home_page.dart';
import 'package:final_project/features/ecommerce/presentation/search/pages/search_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        final query = state.uri.queryParameters['q'] ?? '';
        return SearchPage(initialQuery: query);
      },
    ),
  ],
);
