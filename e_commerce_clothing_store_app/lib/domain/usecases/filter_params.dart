class FilterParams {
  final String? query;
  final String? gender;
  final List<String> brands;
  final List<String> colors;
  final double? minPrice;
  final double? maxPrice;

  FilterParams({
    this.query,
    this.gender,
    this.brands = const [],
    this.colors = const [],
    this.minPrice,
    this.maxPrice,
  });
}
