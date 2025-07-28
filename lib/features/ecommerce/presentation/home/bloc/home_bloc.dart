import 'package:final_project/features/ecommerce/data/usecases/usecase.dart';
import 'package:final_project/features/ecommerce/domain/usecases/get_categories.dart';
import 'package:final_project/features/ecommerce/domain/usecases/get_product.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_event.dart';
import 'package:final_project/features/ecommerce/presentation/home/bloc/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProduct getProducts;
  final GetCategories getCategories;

  HomeBloc({required this.getProducts, required this.getCategories})
    : super(const HomeState()) {
    on<LoadHome>(_onLoad);
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
}
