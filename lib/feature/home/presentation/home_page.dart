import 'package:flutter/material.dart';
import 'package:grocery_app/feature/home/presentation/screens/cart_screen.dart';

import '../data/product_data_source.dart';
import '../data/product_repository_Impl.dart';
import '../domain/entities/product_entity.dart';
import '../domain/use_cases/use_cases.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final GetProducts getProductsUseCase;
  late final SearchProducts searchProductsUseCase;
  late final FilterProductsByPrice filterByPriceUseCase;
  late final FilterProductsByCategory filterByCategoryUseCase;
  late final ToggleLikeProduct toggleLikeProductUseCase;
  late final AddToCart addToCartUseCase;

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _searchQuery = '';
  double _minPrice = 0;
  double _maxPrice = 1000;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    // Инициализация use cases
    // Вставьте инициализацию ваших use cases здесь, например:
    getProductsUseCase =
        GetProducts(ProductRepositoryImpl(ProductLocalDataSource()));
    searchProductsUseCase =
        SearchProducts(ProductRepositoryImpl(ProductLocalDataSource()));
    filterByPriceUseCase =
        FilterProductsByPrice(ProductRepositoryImpl(ProductLocalDataSource()));
    filterByCategoryUseCase = FilterProductsByCategory(
        ProductRepositoryImpl(ProductLocalDataSource()));
    toggleLikeProductUseCase =
        ToggleLikeProduct(ProductRepositoryImpl(ProductLocalDataSource()));
    addToCartUseCase =
        AddToCart(ProductRepositoryImpl(ProductLocalDataSource()));

    _loadProducts(); // Загружаем продукты при инициализации
  }

  Future<void> _loadProducts() async {
    final products = await getProductsUseCase();
    setState(() {
      _products = products;
      _filteredProducts = products; // Отображаем все продукты при открытии
    });
  }

  void _searchProducts(String query) async {
    final results = await searchProductsUseCase(query);
    setState(() {
      _filteredProducts = results;
    });
  }

  void _filterByPrice(double minPrice, double maxPrice) async {
    final results = await filterByPriceUseCase(minPrice, maxPrice);
    setState(() {
      _filteredProducts = results;
    });
  }

  void _filterByCategory(String category) async {
    final results =
        category == 'All' ? _products : await filterByCategoryUseCase(category);
    setState(() {
      _filteredProducts = results;
      _selectedCategory = category; // Обновляем выбранную категорию
    });
  }

  void _toggleLike(Product product) async {
    await toggleLikeProductUseCase(product);
    setState(() {});
  }

  void _addToCart(Product product) async {
    await addToCartUseCase(product);
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product added to cart'),
      ));
    });
  }

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
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // Поле поиска
          TextField(
            onChanged: _searchProducts,
            decoration: const InputDecoration(
              labelText: 'Search',
            ),
          ),
          // Фильтр по категориям
          Container(
            height: 50, // Устанавливаем высоту контейнера
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['All', 'Electronics', 'Fashion'].map((category) {
                return GestureDetector(
                  onTap: () {
                    _filterByCategory(category);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _selectedCategory == category
                          ? Colors.blue
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text(category)),
                  ),
                );
              }).toList(),
            ),
          ),
          // Фильтр по цене
          Slider(
            value: _maxPrice,
            min: 0,
            max: 1000,
            onChanged: (value) {
              _filterByPrice(_minPrice, value);
              setState(() {
                _maxPrice = value; // Обновляем максимальную цену
              });
            },
          ),
          // Список продуктов
          Expanded(
            child: GridView.builder(
                itemCount: _filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return Card(
                    child: Column(
                      children: [
                        Text(product.name),
                        Text(product.price.toString()),
                        IconButton(
                          icon: Icon(product.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () {
                            _toggleLike(product);
                          },
                        ),
                        TextButton(
                            onPressed: () {
                              _addToCart(product);
                            },
                            child: const Text('Add to cart'))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}


