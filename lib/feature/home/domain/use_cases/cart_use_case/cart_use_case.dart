import '../../entities/product_entity.dart';
import '../../repositories/cart_repositories.dart';

class CartUseCase {
  final CartRepository _cartRepository;

  CartUseCase(this._cartRepository);

  Future<List<Product>> getCartProducts() async {
    return await _cartRepository.getCartProducts();
  }
}


class IncreaseQuantityUseCase {
  final CartRepository _cartRepository;

  IncreaseQuantityUseCase(this._cartRepository);

  Future<void> increaseQuantity(Product product) async {
    await _cartRepository.increaseQuantity(product);
  }
}

class DecreaseQuantityUseCase {
  final CartRepository _cartRepository;

  DecreaseQuantityUseCase(this._cartRepository);

  Future<void> decreaseQuantity(Product product) async {
    await _cartRepository.decreaseQuantity(product);
  }
}