import 'package:grocery_app/feature/home/domain/entities/product_entity.dart';

import '../../domain/repositories/cart_repositories.dart';
import '../product_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  @override
  Future<List<Product>> getCartProducts() async {
    return cart;
  }

  @override
  Future<void> increaseQuantity(Product product) async {
    for (var item in cart) {
      if (item.name == product.name) {
        item.quantity++;
        break;
      }
    }
  }

  @override
  Future<void> decreaseQuantity(Product product) async {
    for (var item in cart) {
      if (item.name == product.name) {
        item.quantity--;

        // Проверяем, если количество товара стало 0, то удаляем его из корзины
        if (item.quantity == 0) {
          cart.remove(item);
        }
        break;
      }
    }
  }
}
