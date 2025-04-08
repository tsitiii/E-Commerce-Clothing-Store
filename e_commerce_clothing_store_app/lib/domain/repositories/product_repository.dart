import '../entities/product_entity.dart';
import '../usecases/filter_params.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
  Future<List<ProductEntity>> getProductsByCategory(String category);
  Future<List<ProductEntity>> searchProducts(FilterParams params);
  Future<List<String>> getCategories();
}
