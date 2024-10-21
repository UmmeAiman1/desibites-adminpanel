import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String description;
  String imageUrl;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}

class Studio7teas extends StatefulWidget {
  final VoidCallback onAddProduct;

  const Studio7teas({super.key, required this.onAddProduct});

  @override
  _Studio7teasState createState() => _Studio7teasState();
}

class _Studio7teasState extends State<Studio7teas> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  // final TextEditingController _quantityController = TextEditingController();

  Future<void> addProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection('Studio7teas')
        .doc(product.id)
        .set(product.toMap());
  }

  Future<void> _addProduct() async {
    if (_imageUrlController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      Product newProduct = Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
        price: double.parse(_priceController.text),
      );

      print(newProduct.toMap());

      await addProduct(newProduct);

      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _imageUrlController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Studio7teas'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: _addProduct,
              child: const Text('Add Product', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
