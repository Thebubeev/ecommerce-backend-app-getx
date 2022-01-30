import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final int customerId;
  final List<int> productsId;
  final double deliveryFee;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isCancelled;
  final bool isDelivered;
  final DateTime createdAt;

  const Order(
      {required this.id,
      required this.customerId,
      required this.productsId,
      required this.deliveryFee,
      required this.subtotal,
      required this.total,
      required this.isAccepted,
      required this.isCancelled,
      required this.isDelivered,
      required this.createdAt});
  @override
  List<Object?> get props => [
        id,
        customerId,
        productsId,
        deliveryFee,
        subtotal,
        total,
        isAccepted,
        isCancelled,
        isDelivered,
        createdAt
      ];

  Order copyWith(
    int? id,
    int? customerId,
    List<int>? productsId,
    double? deliveryFee,
    double? subtotal,
    double? total,
    bool? isAccepted,
    bool? isCancelled,
    bool? isDelivered,
    DateTime? createdAt,
  ) {
    return Order(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        productsId: productsId ?? this.productsId,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        subtotal: subtotal ?? this.subtotal,
        total: total ?? this.total,
        isAccepted: isAccepted ?? this.isAccepted,
        isCancelled: isCancelled ?? this.isCancelled,
        isDelivered: isDelivered ?? this.isDelivered,
        createdAt: createdAt ?? this.createdAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productsId': productsId,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isCancelled': isCancelled,
      'isDelivered': isDelivered,
      'createdAt': createdAt,
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    return Order(
        id: snapshot['id'],
        customerId: snapshot['customerId'],
        productsId: List<int>.from(snapshot['productsId']),
        deliveryFee: snapshot['deliveryFee'].toDouble(),
        subtotal: snapshot['subtotal'].toDouble(),
        total: snapshot['total'].toDouble(),
        isAccepted: snapshot['isAccepted'],
        isCancelled: snapshot['isCancelled'],
        isDelivered: snapshot['isDelivered'],
        createdAt: snapshot['createdAt'].toDate());
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  /* static List<Order> orders = [
    Order(
        id: 1,
        customerId: 234,
        productsId: const [1, 2, 3],
        deliveryFee: 10,
        subtotal: 20,
        total: 30,
        isAccepted: true,
        isCancelled: false,
        isDelivered: false,
        createdAt: DateTime.now()),
    Order(
        id: 2,
        customerId: 432,
        productsId: const [1, 2],
        deliveryFee: 10,
        subtotal: 20,
        total: 30,
        isAccepted: true,
        isCancelled: false,
        isDelivered: false,
        createdAt: DateTime.now()),
    Order(
        id: 3,
        customerId: 11,
        productsId: const [1, 2],
        deliveryFee: 10,
        subtotal: 20,
        total: 30,
        isAccepted: true,
        isCancelled: false,
        isDelivered: false,
        createdAt: DateTime.now()),
  ];*/
}
