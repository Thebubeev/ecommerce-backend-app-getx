import 'package:flutter_ecommerce_backend_getx/models/product_model.dart';
import 'package:flutter_ecommerce_backend_getx/services/firestore_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductConroller extends GetxController {
  FirestoreService database = FirestoreService();

  @override
  void onInit() {
    products.bindStream(database.getAllDocuments());
    super.onInit();
  }

  var products = <Product>[].obs;

  var newProduct = {}.obs; // map

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];

  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  void updateProductPrice(Product product, int index, double value) {
    product.price = value;
    products[index] = product;
  }

  void updateProductQuantity(Product product, int index, int value) {
    product.quantity = value;
    products[index] = product;
  }

  void updatePrice(Product product, String field, double value) {
    database.updateDocument(product, field, value);
  }

  void updateQuantity(Product product, String field, double value) {
    database.updateDocument(product, field, value);
  }
}
