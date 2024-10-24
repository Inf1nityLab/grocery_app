// Use case для получения всех продуктов
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}

// Use case для поиска продуктов
class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<List<Product>> call(String query) async {
    return await repository.searchProducts(query);
  }
}

// Use case для фильтрации продуктов по цене
class FilterProductsByPrice {
  final ProductRepository repository;

  FilterProductsByPrice(this.repository);

  Future<List<Product>> call(double minPrice, double maxPrice) async {
    return await repository.filterByPrice(minPrice, maxPrice);
  }
}

// Use case для фильтрации продуктов по категории
class FilterProductsByCategory {
  final ProductRepository repository;

  FilterProductsByCategory(this.repository);

  Future<List<Product>> call(String category) async {
    return await repository.filterByCategory(category);
  }
}

// Use case для лайка
class ToggleLikeProduct {
  final ProductRepository repository;

  ToggleLikeProduct(this.repository);

  Future<void> call(Product product) async {
    await repository.toggleLike(product);
  }
}

class AddToCart {
  final ProductRepository repository;

  AddToCart(this.repository);

  Future<void> call(Product product) async {
    await repository.addToCart(product);
  }
}
