import '../../../domain/entities/product_entity.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final String query;
  final List<ProductEntity> products;
  final SearchStatus status;
  final String? errorMessage;
  final List<String> categories;
  final String? selectedCategory;
  final double? minPrice;
  final double? maxPrice;

  SearchState({
    this.query = '',
    this.products = const [],
    this.status = SearchStatus.initial,
    this.errorMessage,
    this.categories = const [],
    this.selectedCategory,
    this.minPrice,
    this.maxPrice,
  });

  SearchState copyWith({
    String? query,
    List<ProductEntity>? products,
    SearchStatus? status,
    String? errorMessage,
    List<String>? categories,
    String? selectedCategory,
    double? minPrice,
    double? maxPrice,
  }) {
    return SearchState(
      query: query ?? this.query,
      products: products ?? this.products,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
}
