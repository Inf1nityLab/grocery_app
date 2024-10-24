import 'package:grocery_app/feature/home/data/product_data_source.dart';
import '../domain/entities/product_entity.dart';
import '../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProducts() async {
    return await dataSource.getProductsFromDb();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final products = await dataSource.getProductsFromDb();
    return products
        .where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Product>> filterByPrice(double minPrice, double maxPrice) async {
    final products = await dataSource.getProductsFromDb();
    return products
        .where(
            (product) => product.price >= minPrice && product.price <= maxPrice)
        .toList();
  }

  @override
  Future<List<Product>> filterByCategory(String category) async {
    final products = await dataSource.getProductsFromDb();
    return products.where((product) => product.category == category).toList();
  }

  @override
  Future<void> toggleLike(Product product) async {
    product.isLiked = !product.isLiked;
  }

  @override
  Future<void> addToCart(Product product) async {
    Product? existingItem;
    for (var item in cart) {
      if (item.name == product.name) {
        existingItem = item;
        break;
      }
    }

    if (existingItem != null) {
      // Если продукт найден, увеличиваем количество
      existingItem.quantity++;
    } else {
      // Если продукта нет в корзине, добавляем его
      cart.add(product);
    }
  }
}

