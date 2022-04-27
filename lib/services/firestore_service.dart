import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce_backend_getx/models/order_model.dart';
import 'package:flutter_ecommerce_backend_getx/models/product_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getAllDocuments() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Order>> getAllOrders() {
    return _firebaseFirestore
        .collection('checkout')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Order>> getPendingOrders() {
    return _firebaseFirestore
        .collection('checkout')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addDocument(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateDocument(
    Product product,
    String field,
    double newValue,
  ) {
    return _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((snapshots) =>
            snapshots.docs.first.reference.update({field: newValue}));
  }

  Future<void> updateStatus(Order order, String field, dynamic newValue) {
    return _firebaseFirestore
        .collection('checkout')
        .where('id', isEqualTo: order.id)
        .get()
        .then((snapshots) =>
            snapshots.docs.first.reference.update({field: newValue}));
  }
}
