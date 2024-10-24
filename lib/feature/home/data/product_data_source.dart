import 'package:grocery_app/feature/home/data/product_model.dart';

import '../domain/entities/product_entity.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProductsFromDb();
}

class ProductLocalDataSource implements ProductDataSource {
  @override
  Future<List<ProductModel>> getProductsFromDb() async {
    // Пример локальных данных
    return [
      ProductModel(
          name: 'Laptop',
          price: 1000,
          category: 'Electronics',
          description: 'High-end laptop'),
      ProductModel(
          name: 'Smartphone',
          price: 800,
          category: 'Electronics',
          description: 'Latest smartphone'),
      ProductModel(
          name: 'Shoes',
          price: 50,
          category: 'Fashion',
          description: 'Comfortable shoes'),
      ProductModel(
          name: 'Shirt',
          price: 25,
          category: 'Fashion',
          description: 'Stylish shirt'),
      ProductModel(
          name: 'Headphones',
          price: 150,
          category: 'Electronics',
          description: 'Noise-cancelling headphones'),
    ];
  }

}

List<Product> cart = [];
