import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartUseCase cartUseCase;
  late final IncreaseQuantityUseCase increaseQuantityUseCase;
  late final DecreaseQuantityUseCase decreaseQuantityUseCase;
  late final RemoveProductUseCase removeProductUseCase;
  List<Product>? _cartProducts;

  @override
  void initState() {
    // TODO: implement initState
    cartUseCase = CartUseCase(
      CartRepositoryImpl(),
    );
    increaseQuantityUseCase = IncreaseQuantityUseCase(
      CartRepositoryImpl(),
    );

    decreaseQuantityUseCase = DecreaseQuantityUseCase(
      CartRepositoryImpl(),
    );

    removeProductUseCase = RemoveProductUseCase(
      CartRepositoryImpl(),
    );
    getCartProducts();
    super.initState();
  }

  Future<void> getCartProducts() async {
    final cartProducts = await cartUseCase.getCartProducts();
    setState(() {
      _cartProducts = cartProducts;
    });
  }

  Future<void> increaseQuantity(Product product) async {
    setState(() {});
    await increaseQuantityUseCase.increaseQuantity(product);
  }

  Future<void> decreaseQuantity(Product product) async {
    setState(() {});
    await decreaseQuantityUseCase.decreaseQuantity(product);
    getCartProducts();
  }

  Future<void> removeProduct(Product product) async {
    await removeProductUseCase.removeProduct(product); // Используем метод репозитория
    getCartProducts(); // Обновляем список
  }

  double calculateTotal() {
    if (_cartProducts == null) return 0;
    double total = 0;
    for (var product in _cartProducts!) {
      total += product.price * product.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: _cartProducts!.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartProducts?.length,
              itemBuilder: (context, index) {
                final product = _cartProducts![index];
                return Dismissible(
                  key: Key(product.name), // Уникальный ключ для каждого продукта
                  direction: DismissDirection.endToStart, // Свайп влево для удаления
                  onDismissed: (direction) {
                    removeProduct(product);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text('${product.price * product.quantity} \$'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              decreaseQuantity(product);
                            },
                          ),
                          Text(product.quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              increaseQuantity(product);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery: 10 \$'),
                Text('Total: ${calculateTotal() + 10} \$'), // Общий счет плюс доставка
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String category;
  final String description;
  bool isLiked;
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    this.isLiked = false,
    this.quantity = 1,
  });
}

abstract class CartRepository {
  Future<List<Product>> getCartProducts();

  Future<void> increaseQuantity(Product product);

  Future<void> decreaseQuantity(Product product);
  Future<void> removeProduct(Product product);
}

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

class RemoveProductUseCase {
  final CartRepository _cartRepository;

  RemoveProductUseCase(this._cartRepository);

  Future<void> removeProduct(Product product) async {
    await _cartRepository.removeProduct(product);
  }
}

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

  @override
  Future<void> removeProduct(Product product) async{
    cart.removeWhere((item) => item.name == product.name);
  }
}

List<Product> cart = [
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
];

class ProductModel extends Product {
  ProductModel({
    required super.name,
    required super.price,
    required super.category,
    required super.description,
    super.isLiked,
    super.quantity = 1,
  });
}
