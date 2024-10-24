import 'package:grocery_app/feature/home/data/product_model.dart';

import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> searchProducts(String query);
  Future<List<Product>> filterByPrice(double minPrice, double maxPrice);
  Future<List<Product>> filterByCategory(String category);
  Future<void> toggleLike(Product product);
  Future<void> addToCart(Product product);
}
