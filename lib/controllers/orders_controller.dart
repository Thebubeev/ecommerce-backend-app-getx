import 'package:flutter_ecommerce_backend_getx/models/order_model.dart';
import 'package:flutter_ecommerce_backend_getx/services/firestore_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  FirestoreService database = FirestoreService();
  var orders = <Order>[].obs;
  var pendingOrders = <Order>[].obs;

  @override
  void onInit() {
    orders.bindStream(database.getAllOrders());
    pendingOrders.bindStream(database.getPendingOrders());
    super.onInit();
  }

  void updateStatus(Order order, String field, dynamic value) {
    database.updateStatus(order, field, value);
  }
}
