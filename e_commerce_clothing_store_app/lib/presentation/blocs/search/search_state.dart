import '../../../domain/entities/product_entity.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final String query;
  final List<ProductEntity> products;
  final SearchStatus status;
  final String? errorMessage;
  final List<String> categories;
  final String? selectedGender;
  final List<String> selectedBrands;
  final List<String> selectedColors;
  final double? minPrice;
  final double? maxPrice;

  SearchState({
    this.query = '',
    this.products = const [],
    this.status = SearchStatus.initial,
    this.errorMessage,
    this.categories = const [],
    this.selectedGender,
    this.selectedBrands = const [],
    this.selectedColors = const [],
    this.minPrice,
    this.maxPrice,
  });

  SearchState copyWith({
    String? query,
    List<ProductEntity>? products,
    SearchStatus? status,
    String? errorMessage,
    List<String>? categories,
    String? selectedGender,
    List<String>? selectedBrands,
    List<String>? selectedColors,
    double? minPrice,
    double? maxPrice,
  }) {
    return SearchState(
      query: query ?? this.query,
      products: products ?? this.products,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      selectedColors: selectedColors ?? this.selectedColors,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
}
