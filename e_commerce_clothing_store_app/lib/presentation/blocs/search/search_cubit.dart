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
          gender: state.selectedGender,
          brands: state.selectedBrands,
          colors: state.selectedColors,
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

  void updatePriceRange(double min, double max) {
    emit(state.copyWith(minPrice: min, maxPrice: max));
    searchProducts();
  }

  void updateGender(String? gender) {
    emit(state.copyWith(selectedGender: gender));
    searchProducts();
  }

  void updateBrand(String brand, bool selected) {
    final updatedBrands = List<String>.from(state.selectedBrands);
    if (selected) {
      updatedBrands.add(brand);
    } else {
      updatedBrands.remove(brand);
    }
    emit(state.copyWith(selectedBrands: updatedBrands));
    searchProducts();
  }

  void updateColor(String color, bool selected) {
    final updatedColors = List<String>.from(state.selectedColors);
    if (selected) {
      updatedColors.add(color);
    } else {
      updatedColors.remove(color);
    }
    emit(state.copyWith(selectedColors: updatedColors));
    searchProducts();
  }

  void clearFilters() {
    emit(state.copyWith(
      selectedGender: null,
      selectedBrands: [],
      selectedColors: [],
      minPrice: null,
      maxPrice: null,
    ));
    searchProducts();
  }
}
