import 'package:flutter/material.dart';
import 'package:untitled/UI/Screen/update_product.dart';

import '../../Model/product_model.dart';
import '../Screen/delete_product.dart';

class ProductItems extends StatelessWidget {
  const ProductItems({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  static const String defaultImageUrl =
      'https://i.pinimg.com/736x/33/9e/36/339e361934a745aa0525f7d6137c142a.jpg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 5,
            child: ListTile(
              leading: Image.network(
                productModel.img ?? defaultImageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png', // Replace with actual placeholder image
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                },
              ),
              title: Text('Product Name: ${productModel.productName ?? 'Not Available'}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Code: ${productModel.productCode ?? 'Not Available'}'),
                  const SizedBox(height: 5),
                  Text('Unit Price: ${productModel.unitPrice ?? 'Not Available'}'),
                  const SizedBox(height: 5),
                  Text('Qty: ${productModel.qty ?? 'Not Available'}'),
                  const SizedBox(height: 5),
                  Text('Total Price: ${productModel.totalPrice ?? 'Not Available'}'),
                  const SizedBox(height: 5),
                  Text('Created Date: ${productModel.createdDate ?? 'Not Available'}'),
                ],
              ),
              trailing: Wrap(

                spacing: 1,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        DeleteProduct.routeName,
                        arguments: productModel,
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        UpdateProduct.routeName,
                        arguments: productModel,
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
