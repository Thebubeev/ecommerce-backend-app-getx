import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_backend_getx/models/product_model.dart';

class Order extends Equatable {
  final String? id;
  final List<dynamic>? images;
  final String? customerName;
  final String? customerEmail;
  final Map<String, dynamic>? customerAddress;
  final String? city;
  final String? country;
  final String? zipCode;
  final List<dynamic>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  final bool? isAccepted;
  final bool? isDelivered;
  final bool? isCancelled;
  final DateTime? orderedAt;

  const Order(
      {required this.id, required this.images,
      required this.customerName,
      required this.customerEmail,
      required this.customerAddress,
      this.city,
      this.country,
      this.zipCode,
      required this.products,
      required this.deliveryFee,
      required this.subtotal,
      required this.total,
      required this.isAccepted,
      required this.isCancelled,
      required this.isDelivered,
      required this.orderedAt});
  @override
  List<Object?> get props => [
    id,
        images,
        customerName,
        customerEmail,
        customerAddress,
        products,
        subtotal,
        deliveryFee,
        total,
        isAccepted,
        isDelivered,
        isCancelled,
        orderedAt
      ];

  Order copyWith(
    String? id,
    List<dynamic>? images,
    String? customerName,
    String? customerEmail,
    Map<String, dynamic>? customerAddress,
    List<dynamic>? products,
    String? deliveryFee,
    String? subtotal,
    String? total,
    bool? isAccepted,
    bool? isCancelled,
    bool? isDelivered,
    DateTime? orderedAt,
  ) {
    return Order(
      id: id ?? this.id,
      images: images ?? this.images,
        customerName: customerName ?? this.customerName,
        customerEmail: customerEmail ?? this.customerEmail,
        customerAddress: customerAddress ?? this.customerAddress,
        products: products ?? this.products,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        subtotal: subtotal ?? this.subtotal,
        total: total ?? this.total,
        isAccepted: isAccepted ?? this.isAccepted,
        isCancelled: isCancelled ?? this.isCancelled,
        isDelivered: isDelivered ?? this.isDelivered,
        orderedAt: orderedAt ?? this.orderedAt);
  }

  Map<String, dynamic> toMap() {
    Map customerAddress = Map();
    customerAddress['address'] = customerAddress;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['zipCode'] = zipCode;
    return {
    'id' : id,
    'images' : images,
      'customerAddress': customerAddress,
      'customerName': customerName!,
      'customerEmail': customerEmail!,
      'products': products!.map((product) => product.name).toList(),
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isCancelled': isCancelled,
      'isDelivered': isDelivered,
      'orderedAt': orderedAt
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    return Order(
      id: snapshot['id'],
      images: snapshot['images'],
        customerName: snapshot['customerName'],
        customerEmail: snapshot['customerEmail'],
        customerAddress: Map<String, dynamic>.from(snapshot['customerAddress']),
        products: List<dynamic>.from(snapshot['products']),
        deliveryFee: snapshot['deliveryFee'],
        subtotal: snapshot['subtotal'],
        total: snapshot['total'],
        isAccepted: snapshot['isAccepted'],
        isCancelled: snapshot['isCancelled'],
        isDelivered: snapshot['isDelivered'],
        orderedAt: snapshot['orderedAt'].toDate());
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
