import '../domain/entities/product_entity.dart';

class ProductModel extends Product {
  ProductModel({
    required super.name,
    required super.price,
    required super.category,
    required super.description,
    super.isLiked,
    super.quantity = 1,
  });

  // fromJson и toJson для работы с данными
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      isLiked: json['isLiked'] ?? false,
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'isLiked': isLiked,
      'quantity': quantity,
    };
  }
}
