import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/usecases/filter_params.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductRepository _repository;

  SearchCubit(this._repository) : super(SearchState()) {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _repository.getCategories();
      emit(state.copyWith(categories: categories));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> searchProducts() async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final products = await _repository.searchProducts(
        FilterParams(
          query: state.query.isEmpty ? null : state.query,
          category: state.selectedCategory,
          minPrice: state.minPrice,
          maxPrice: state.maxPrice,
        ),
      );

      emit(state.copyWith(
        status: SearchStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateQuery(String query) {
    emit(state.copyWith(query: query));
    searchProducts();
  }

  void updateCategory(String? category) {
    emit(state.copyWith(selectedCategory: category));
    searchProducts();
  }

  void updatePriceRange(double min, double max) {
    emit(state.copyWith(minPrice: min, maxPrice: max));
    searchProducts();
  }

  void clearFilters() {
    emit(state.copyWith(
      selectedCategory: null,
      minPrice: null,
      maxPrice: null,
    ));
    searchProducts();
  }
}
