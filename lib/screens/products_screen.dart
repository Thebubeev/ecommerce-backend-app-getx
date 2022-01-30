import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_backend_getx/controllers/product_controller.dart';
import 'package:flutter_ecommerce_backend_getx/models/product_model.dart';
import 'package:flutter_ecommerce_backend_getx/screens/new_product_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  ProductConroller productConroller = Get.put(ProductConroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Screen'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: InkWell(
                onTap: () {
                  Get.to(() => NewProductScreen());
                },
                child: Card(
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          )),
                      const Text(
                        'Add a new Product',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SizedBox(
                        height: 250,
                        child: ProductCard(
                          product: productConroller.products[index],
                          index: index,
                        ));
                  },
                  itemCount: productConroller.products.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  ProductCard({Key? key, required this.product, required this.index})
      : super(key: key);

  ProductConroller productConroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            product.description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  product.imageUrl == null
                      ? 'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg'
                      : product.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Column(
                    children: [
                      Row(children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Slider(
                          value: product.price,
                          onChanged: (value) {
                            productConroller.updateProductPrice(
                                product, index, value);
                          },
                          onChangeEnd: (value) {
                            productConroller.updatePrice(
                                product, 'price', value);
                          },
                          min: 0,
                          max: 25,
                          divisions: 10,
                          activeColor: Colors.black,
                          inactiveColor: Colors.black12,
                        ),
                      ]),
                      Text(
                        '\$' + product.price.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Slider(
                          value: product.quantity.toDouble(),
                          onChanged: (value) {
                            productConroller.updateProductQuantity(
                                product, index, value.toInt());
                          },
                          onChangeEnd: (value) {
                            productConroller.updatePrice(
                                product, 'quantity', value);
                          },
                          min: 0,
                          max: 25,
                          divisions: 10,
                          activeColor: Colors.black,
                          inactiveColor: Colors.black12,
                        ),
                      ]),
                      Text(
                        product.quantity.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
