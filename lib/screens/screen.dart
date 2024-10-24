import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';

// Entity
class ProductEntity {
  final String name;
  final double price;
  final String category;
  final String description;
  bool isLiked;

  ProductEntity({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    this.isLiked = false,
  });

  @override
  String toString() {
    return 'ProductEntity(name: $name, price: $price, category: $category, description: $description)';
  }
}

// Model
class ProductModel extends ProductEntity {
  ProductModel({
    required super.name,
    required super.price,
    required super.category,
    required super.description,
    super.isLiked,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      isLiked: json['isLiked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'isLiked': isLiked,
    };
  }
}

// Repository
abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
  Future<void> addToCart(ProductEntity product);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    // Получаем продукты из источника данных
    final List<ProductModel> products = await dataSource.getProductsFromDb();

    // Преобразуем List<ProductModel> в List<ProductEntity>
    return products.map((product) => product as ProductEntity).toList();
  }

  @override
  Future<void> addToCart(ProductEntity product) async {
    return dataSource.addToCart(product);
  }
}



// DataSource
abstract class ProductDataSource {
  Future<List<ProductModel>> getProductsFromDb();
  Future<void> addToCart(ProductEntity product);
  Future<List<ProductEntity>> getCartProducts();
}

class ProductLocalDataSource implements ProductDataSource {
  final List<ProductEntity> _cart = [];

  @override
  Future<List<ProductModel>> getProductsFromDb() async {
    return [
      ProductModel(name: 'Laptop', price: 1000, category: 'Electronics', description: 'High-end laptop'),
      ProductModel(name: 'Smartphone', price: 800, category: 'Electronics', description: 'Latest smartphone'),
    ];
  }

  @override
  Future<void> addToCart(ProductEntity product) async {
    _cart.add(product);
    print('Product added to cart: $_cart');
  }

  @override
  Future<List<ProductEntity>> getCartProducts() async {
    return _cart;
  }
}

// BLoC
abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class AddProductToCart extends ProductEvent {
  final ProductEntity product;

  AddProductToCart(this.product);
}

class ProductState {
  final List<ProductEntity> products;
  final List<ProductEntity> cart;

  ProductState({required this.products, required this.cart});
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductState(products: [], cart: [])) {
    on<LoadProducts>((event, emit) async {
      final products = await repository.getProducts();
      emit(ProductState(products: products, cart: state.cart));
    });

    on<AddProductToCart>((event, emit) async {
      await repository.addToCart(event.product);
      final updatedCart = List.from(state.cart)..add(event.product);
      emit(ProductState(products: state.products, cart: updatedCart.cast<ProductEntity>()));
    });
  }
}

// Main App



// Product List Screen
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shop),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return GridView.builder(
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Card(
                child: Column(
                  children: [
                    Text(product.name),
                    Text(product.price.toString()),
                    TextButton(
                      onPressed: () {
                        context.read<ProductBloc>().add(AddProductToCart(product));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Product added to cart')),
                        );
                      },
                      child: const Text('Add to cart'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Cart Screen
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state.cart.isEmpty
              ? const Center(child: Text('Корзина пуста'))
              : ListView.builder(
            itemCount: state.cart.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(state.cart[index].name),
                  subtitle: Text(state.cart[index].price.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}






