
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled/Model/product_model.dart';

class DeleteProduct extends StatefulWidget {
  const DeleteProduct({super.key, required this.productModel});
  final ProductModel productModel;

  static const String routeName = '/delete_product';

  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  bool _inProgress = false;

  Future<void> _deleteProduct() async {
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/${widget.productModel.id}');

    setState(() {
      _inProgress = true;
    });

    try {
      Response response = await get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully!')),
        );
        Navigator.pop(context); // Navigate back after successful deletion
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete product. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    } finally {
      setState(() {
        _inProgress = false;
      });
    }
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this product? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                _deleteProduct();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Product'),
      ),
      body: _inProgress
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 7,
              child: Column(
                children: [
                  Card(
                      child:Padding(
                        padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                        child: Text(widget.productModel.productName ?? 'Unknown Product',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                      ),

                    elevation: 5,
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        widget.productModel.img ?? 'https://via.placeholder.com/150',width:double.infinity,height: 350,fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  ListTile(

                   //title: Text(widget.productModel.productName ?? 'Unknown Product'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Code: ${widget.productModel.productCode ?? 'N/A'}'),
                        const SizedBox(height: 10),
                        Text('Price: ${widget.productModel.unitPrice ?? 'N/A'}'),
                        const SizedBox(height: 10),
                        Text('Quantity: ${widget.productModel.qty ?? 'N/A'}'),
                        const SizedBox(height: 10),
                        Text('Total Price: ${widget.productModel.totalPrice ?? 'N/A'}'),
                       // const SizedBox(height: 10),
                       // Text('Created Date: ${widget.productModel.createdDate ?? 'N/A'}'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _showDeleteConfirmationDialog,
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
