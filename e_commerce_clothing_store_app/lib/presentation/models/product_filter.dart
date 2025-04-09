import 'package:flutter/material.dart';

class ProductFilter {
  final String? query;
  final String? gender;
  final List<String> brands;
  final RangeValues priceRange;

  ProductFilter({
    this.query,
    this.gender,
    this.brands = const [],
    this.priceRange = const RangeValues(0, 500),
  });

  ProductFilter copyWith({
    String? query,
    String? gender,
    List<String>? brands,
    RangeValues? priceRange,
  }) {
    return ProductFilter(
      query: query ?? this.query,
      gender: gender ?? this.gender,
      brands: brands ?? this.brands,
      priceRange: priceRange ?? this.priceRange,
    );
  }
}
