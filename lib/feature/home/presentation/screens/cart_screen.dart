import 'package:flutter/material.dart';
import 'package:grocery_app/feature/home/data/product_data_source.dart';
import 'package:grocery_app/feature/home/domain/repositories/cart_repositories.dart';

import '../../data/cart_repository_imple/cart_repository_imple.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/cart_use_case/cart_use_case.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartUseCase cartUseCase;
  late final IncreaseQuantityUseCase increaseQuantityUseCase;
  late final DecreaseQuantityUseCase decreaseQuantityUseCase;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: _cartProducts!.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : ListView.builder(
              itemCount: _cartProducts?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      title: Text(_cartProducts?[index].name ?? ''),
                      subtitle:
                          Text('${_cartProducts![index].price * _cartProducts![index].quantity} \$'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              decreaseQuantity(_cartProducts![index]);
                            },
                          ),
                          Text(_cartProducts?[index].quantity.toString() ?? ''),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              increaseQuantity(_cartProducts![index]);
                            },
                          ),
                        ],
                      )),
                );
              },
            ),
    );
  }
}
