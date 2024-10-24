// Product entity
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
