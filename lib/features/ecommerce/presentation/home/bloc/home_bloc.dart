import 'package:final_project/features/ecommerce/data/usecases/usecase.dart';
import 'package:final_project/features/ecommerce/domain/usecases/get_categories.dart';
import 'package:final_project/features/ecommerce/domain/usecases/get_product.dart';
import 'package:final_project/features/ecommerce/domain/usecases/get_products_by_category.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_event.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProduct getProducts;
  final GetCategories getCategories;
  final GetProductsByCategory getProductsByCategory;

  HomeBloc({
    required this.getProducts,
    required this.getCategories,
    required this.getProductsByCategory,
  }) : super(const HomeState()) {
    on<LoadHome>(_onLoad);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<RefreshHome>(_onRefreshHome);
  }

  Future<void> _onLoad(LoadHome event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, isLoadingCategories: true));

    final categoriesResult = await getCategories(NoParams());
    categoriesResult.fold(
      (failure) => emit(
        state.copyWith(error: failure.message, isLoadingCategories: false),
      ),
      (categories) => emit(
        state.copyWith(
          categories: ['All', ...categories],
          isLoadingCategories: false,
        ),
      ),
    );

    final productsResult = await getProducts(NoParams());
    productsResult.fold(
      (failure) =>
          emit(state.copyWith(error: failure.message, isLoading: false)),
      (products) => emit(state.copyWith(products: products, isLoading: false)),
    );
  }

  Future<void> _onRefreshHome(
    RefreshHome event,
    Emitter<HomeState> emit,
  ) async {
    add(LoadHome());
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(selectedCategory: event.category, isLoading: true));

    if (event.category == 'All') {
      final result = await getProducts(NoParams());
      result.fold(
        (failure) =>
            emit(state.copyWith(error: failure.message, isLoading: false)),
        (products) =>
            emit(state.copyWith(products: products, isLoading: false)),
      );
    } else {
      final result = await getProductsByCategory(
        CategoryParams(category: event.category),
      );
      result.fold(
        (failure) =>
            emit(state.copyWith(error: failure.message, isLoading: false)),
        (products) =>
            emit(state.copyWith(products: products, isLoading: false)),
      );
    }
  }
}
