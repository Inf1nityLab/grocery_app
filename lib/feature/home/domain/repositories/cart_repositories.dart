

import '../entities/product_entity.dart';

abstract class CartRepository {

  Future<List<Product>> getCartProducts();
  Future<void> increaseQuantity(Product product);
  Future<void> decreaseQuantity(Product product);

}