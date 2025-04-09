import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/search/search_cubit.dart';
import '../../blocs/search/search_state.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Filter'),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<SearchCubit>().clearFilters();
                  Navigator.pop(context);
                },
                child: const Text('Clear'),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildCategorySection(context, state),
              const SizedBox(height: 24),
              _buildPriceRangeSection(context, state),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategorySection(BuildContext context, SearchState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: const Text('All'),
              selected: state.selectedCategory == null,
              onSelected: (selected) {
                if (selected) {
                  context.read<SearchCubit>().updateCategory(null);
                }
              },
            ),
            ...state.categories.map((category) {
              return FilterChip(
                label: Text(category),
                selected: state.selectedCategory == category,
                onSelected: (selected) {
                  context
                      .read<SearchCubit>()
                      .updateCategory(selected ? category : null);
                },
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection(BuildContext context, SearchState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        RangeSlider(
          values: RangeValues(
            state.minPrice ?? 0,
            state.maxPrice ?? 1000,
          ),
          min: 0,
          max: 1000,
          divisions: 100,
          labels: RangeLabels(
            '\$${(state.minPrice ?? 0).toStringAsFixed(0)}',
            '\$${(state.maxPrice ?? 1000).toStringAsFixed(0)}',
          ),
          onChanged: (values) {
            context
                .read<SearchCubit>()
                .updatePriceRange(values.start, values.end);
          },
        ),
      ],
    );
  }
}
