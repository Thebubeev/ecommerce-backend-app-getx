import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String category;
  final String description;
  final String? imageUrl;
  final bool isRecommended;
  final bool isPopular;
  double price;
  int quantity;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.description,
      required this.imageUrl,
      required this.isRecommended,
      required this.isPopular,
      this.price = 0,
      this.quantity = 0});
  @override
  List<Object?> get props => [
        id,
        name,
        category,
        description,
        imageUrl,
        isRecommended,
        isPopular,
        price,
        quantity
      ];

  Product copyWith(
      int? id,
      String? name,
      String? category,
      String? description,
      String? imageUrl,
      bool? isRecommended,
      bool? isPopular,
      double? price,
      int? quantity) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        isRecommended: isRecommended ?? this.isRecommended,
        isPopular: isPopular ?? this.isPopular,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
        id: snapshot['id'],
        name: snapshot['name'],
        category: snapshot['category'],
        description: snapshot['description'],
        imageUrl: snapshot['imageUrl'],
        isRecommended: snapshot['isRecommended'],
        isPopular: snapshot['isPopular'],
        price: snapshot['price'],
        quantity: snapshot['quantity'].toInt());
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  static List<Product> products = [
    Product(
        id: 1,
        name: 'Soft Drinks #1',
        category: 'Soft Drinks',
        description: 'Fresh and cold',
        imageUrl:
            'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80',
        isRecommended: true,
        isPopular: false),
    Product(
        id: 2,
        name: 'Soft Drinks #2',
        category: 'Soft Drinks',
        description: 'Fresh and cold',
        imageUrl:
            'https://images.unsplash.com/photo-1534057308991-b9b3a578f1b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        isRecommended: false,
        isPopular: true),
    Product(
        id: 3,
        name: 'Water #1',
        category: 'Water',
        description: 'Fresh and cold',
        imageUrl:
            'https://static.toiimg.com/thumb/72111682.cms?width=680&height=512&imgsize=554084',
        isRecommended: true,
        isPopular: false),
    Product(
        id: 4,
        name: 'Water #2',
        category: 'Water',
        description: 'Fresh and cold',
        imageUrl:
            'https://images.unsplash.com/photo-1559839914-17aae19cec71?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        isRecommended: false,
        isPopular: true),
    Product(
        id: 5,
        name: 'Smoothies #1',
        category: 'Smoothies',
        description: 'Fresh and cold',
        imageUrl:
            'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80',
        isRecommended: true,
        isPopular: false),
    Product(
        id: 6,
        name: 'Smoothies #2',
        category: 'Smoothies',
        description: 'Fresh and cold',
        imageUrl:
            'https://images.unsplash.com/photo-1526424382096-74a93e105682?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        isRecommended: false,
        isPopular: true),
  ]; 
}
