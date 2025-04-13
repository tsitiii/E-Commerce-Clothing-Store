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
            title: const Text(
              'Filter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Gender'),
                  const SizedBox(height: 12),
                  _buildChipSection(['All', 'Men', 'Women']),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Brand'),
                  const SizedBox(height: 12),
                  _buildChipSection(
                      ['Adidas', 'Puma', 'CR7', 'Nike', 'Yeezy', 'Supreme']),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Price Range'),
                  const SizedBox(height: 12),
                  _buildPriceRangeSlider(context),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Color'),
                  const SizedBox(height: 12),
                  _buildChipSection(
                      ['White', 'Black', 'Grey', 'Yellow', 'Red', 'Green']),
                  const SizedBox(height: 24),
                  _buildAnotherOption(),
                  const SizedBox(height: 32),
                  _buildApplyButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildChipSection(List<String> options) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            bool isSelected = false;
            if (options.contains('All')) {
              // Gender section
              isSelected = state.selectedGender == option ||
                  (option == 'All' && state.selectedGender == null);
            } else if (options.contains('Nike')) {
              // Brand section
              isSelected = state.selectedBrands.contains(option);
            } else if (options.contains('White')) {
              // Color section
              isSelected = state.selectedColors.contains(option);
            }

            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                final cubit = context.read<SearchCubit>();
                if (options.contains('All')) {
                  cubit.updateGender(
                      selected ? (option == 'All' ? null : option) : null);
                } else if (options.contains('Nike')) {
                  cubit.updateBrand(option, selected);
                } else if (options.contains('White')) {
                  cubit.updateColor(option, selected);
                }
              },
              backgroundColor: Colors.grey[200],
              selectedColor: const Color(0xFF6C63FF),
              labelStyle: const TextStyle(fontSize: 14),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPriceRangeSlider(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${state.minPrice?.toStringAsFixed(0) ?? "16"}',
                    style: TextStyle(color: Colors.grey[600])),
                Text('\$${state.maxPrice?.toStringAsFixed(0) ?? "543"}',
                    style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xFF6C63FF),
                inactiveTrackColor: Colors.grey[200],
                thumbColor: const Color(0xFF6C63FF),
              ),
              child: RangeSlider(
                values: RangeValues(
                  state.minPrice ?? 16,
                  state.maxPrice ?? 543,
                ),
                min: 16,
                max: 543,
                onChanged: (values) {
                  context
                      .read<SearchCubit>()
                      .updatePriceRange(values.start, values.end);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnotherOption() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: const Text('Another option'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          () {};
        },
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          context.read<SearchCubit>().searchProducts();
          Navigator.pop(context);
        },
        child: const Text(
          'Apply Filter',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
