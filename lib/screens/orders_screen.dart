import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_backend_getx/controllers/orders_controller.dart';
import 'package:flutter_ecommerce_backend_getx/models/order_model.dart';
import 'package:flutter_ecommerce_backend_getx/models/product_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Screen'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (context, index) {
                    return OrderCard(
                      order: orderController.pendingOrders[index],
                      index: index,
                    );
                  },
                  itemCount: orderController.pendingOrders.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final int index;
  OrderCard({Key? key, required this.order, required this.index})
      : super(key: key);

  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    // var products = Product.products
    //    .where((product) => order.productsId.contains(product.id))
    //   .toList();
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Date: ${DateFormat('EEEE, M/d/y').format(order.orderedAt!)}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Id: ${order.id}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            order.images![index] ??
                                'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg',
                            fit: BoxFit.cover,
                            height: 80,
                            width: 70,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          order.products![index] + ' #${index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: order.products!.length,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Delivery Fee',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      '${order.deliveryFee}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    order.isAccepted!
                        ? ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            child: const Text('Deliver'),
                            onPressed: () {
                              orderController.updateStatus(
                                  order, 'isDelivered', !order.isDelivered!);
                            },
                          )
                        : ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            child: const Text('Accept'),
                            onPressed: () {
                              orderController.updateStatus(
                                  order, 'isAccepted', !order.isAccepted!);
                            },
                          )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      '${order.total}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    ElevatedButton(
                      child: const Text('Cancel'),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        orderController.updateStatus(
                            order, 'isCancelled', !order.isCancelled!);
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
