import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_backend_getx/screens/orders_screen.dart';
import 'package:flutter_ecommerce_backend_getx/screens/products_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My eCommerce'),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductsScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text('Go to Products'),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => OrdersScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text('Go to Orders'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
