import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_backend_getx/controllers/product_controller.dart';
import 'package:flutter_ecommerce_backend_getx/models/product_model.dart';
import 'package:flutter_ecommerce_backend_getx/services/firebase_storage.dart';
import 'package:flutter_ecommerce_backend_getx/services/firestore_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class NewProductScreen extends StatefulWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final ProductConroller productConroller = Get.find();

  FirebaseStorage storage = FirebaseStorage();

  FirestoreService database = FirestoreService();

  bool isPopular = false;
  bool isRecommended = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('New Product Screen'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView(
            children: [
              SizedBox(
                height: 100,
                child: InkWell(
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    final XFile? xFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (xFile == null) {
                      Get.snackbar('You should select the picture', '',
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      await storage.loadImage(xFile);
                      var imageUrl =
                          await storage.getDownloadLinkUrl(xFile.name);
                      productConroller.newProduct.update(
                          'imageUrl', (_) => imageUrl,
                          ifAbsent: () => imageUrl);
                      Get.snackbar(
                          "You have successfully selected the picture!", '',
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.green,
                          snackPosition: SnackPosition.BOTTOM);
                      print(productConroller.newProduct['imageUrl']);
                    }
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
                          'Add an Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Product information',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              _buildTextFormField('Product ID', 'id', productConroller),
              _buildTextFormField('Product Name', 'name', productConroller),
              _buildTextFormField(
                  'Product Description', 'description', productConroller),
              _buildTextFormField(
                  'Product Category', 'category', productConroller),
              const SizedBox(
                height: 10,
              ),
              _buildSlider(
                  'Price', productConroller, 'price', productConroller.price),
              _buildSlider('Quantity', productConroller, 'quantity',
                  productConroller.quantity),
              const SizedBox(
                height: 10,
              ),
              _buildCheckboxIsRecommended(
                'Recommended',
                'isRecommended',
                productConroller,
              ),
              _buildCheckboxIsPopular(
                'Popular',
                'isPopular',
                productConroller,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    database
                        .addDocument(
                          Product(
                              id: int.parse(productConroller.newProduct['id']),
                              name: productConroller.newProduct['name'],
                              category: productConroller.newProduct['category'],
                              description:
                                  productConroller.newProduct['description'],
                              imageUrl: productConroller.newProduct['imageUrl'],
                              isRecommended: productConroller
                                      .newProduct['isRecommended'] ??
                                  false,
                              isPopular:
                                  productConroller.newProduct['isPopular'],
                              price: productConroller.newProduct['price'],
                              quantity: productConroller.newProduct['quantity']
                                  .toInt()),
                        )
                        .then((_) {});
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCheckboxIsRecommended(
      String title, String name, ProductConroller productConroller) {
    return Row(
      children: [
        SizedBox(
          width: 145,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Checkbox(
          value: isRecommended,
          onChanged: (value) {
            setState(() {
              isRecommended = value!;
            });
            productConroller.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
          activeColor: Colors.black12,
          checkColor: Colors.black,
        ),
      ],
    );
  }

  Row _buildCheckboxIsPopular(
      String title, String name, ProductConroller productConroller) {
    return Row(
      children: [
        SizedBox(
          width: 145,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Checkbox(
          value: isPopular,
          onChanged: (value) {
            setState(() {
              isPopular = value!;
            });
            productConroller.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
          activeColor: Colors.black12,
          checkColor: Colors.black,
        ),
      ],
    );
  }

  Column _buildSlider(String title, ProductConroller productConroller,
      String name, double? controllerValue) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 75,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Slider(
                value: (controllerValue == null) ? 0 : controllerValue,
                onChanged: (value) {
                  productConroller.newProduct.update(
                    name,
                    (_) => value,
                    ifAbsent: () => value,
                  );
                },
                min: 0,
                max: 25,
                divisions: 10,
                activeColor: Colors.black,
                inactiveColor: Colors.black12,
              ),
            ),
          ],
        ),
        Text(
          title == 'Price'
              ? controllerValue == null
                  ? '\$0'
                  : '\$' + controllerValue.toString()
              : controllerValue == null
                  ? '0'
                  : controllerValue.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  TextFormField _buildTextFormField(
          String hintText, String name, ProductConroller productConroller) =>
      TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onChanged: (value) {
          productConroller.newProduct.update(
            name,
            (_) => value,
            ifAbsent: () => value,
          );
        },
      );
}
