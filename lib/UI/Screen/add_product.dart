import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static const String routeName='/add_product';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _productNameController=TextEditingController();
  final TextEditingController _productCodeController=TextEditingController();
  final TextEditingController _imageController=TextEditingController();
  final TextEditingController _unitPriceController=TextEditingController();
  final TextEditingController _quantityController=TextEditingController();
  final TextEditingController _totalPriceController=TextEditingController();
 // final TextEditingController _createdDateController=TextEditingController();

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
 final  bool _inProgress=false;

  Future<void> _postProductList()async{
    _inProgress==true;
    setState(() {});
    Uri uri=Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Map<String,dynamic> requestBody={
      "ProductName": _productNameController.text.trim(),
      "ProductCode": _productCodeController.text.trim(),
      "Img": _imageController.text.trim(),
      "UnitPrice":_unitPriceController.text.trim(),
      "Qty": _quantityController.text.trim(),
      "TotalPrice":_totalPriceController.text.trim(),
     // "CreatedDate":_createdDateController.text.trim(),
    };
    Response response =await post(
      uri,
      headers: {'Content-type':'application/json'},
        body: jsonEncode(requestBody)
    );
    _inProgress==false;
    setState(() {});
    if(response.statusCode==200){
      _clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Your product is add Successfully')
          )
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Your product add fail')
          )
      );
    }

  }

  void _clear(){
    _productNameController.clear();
    _productCodeController.clear();
    _imageController.clear();
    _unitPriceController.clear();
    _quantityController.clear();
    _totalPriceController.clear();
   // _createdDateController.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _productNameController.dispose();
    _productCodeController.dispose();
    _imageController.dispose();
    _unitPriceController.dispose();
    _quantityController.dispose();
    _totalPriceController.dispose();
   // _createdDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add Product')
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _productForm(),
        ),
      )
    );
  }

  Form _productForm() {
    return Form(
          key: _formKey,
            child: Column(
              children: [
                Card(
                  elevation: 7,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _productNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'product name'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter product name!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _productCodeController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Code',
                        hintText: 'product code'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter product code!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _imageController,
                    keyboardType: TextInputType.url,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Image',
                        hintText: 'Image url'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter product image url!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _unitPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Unit Price',
                        hintText: 'product Unit Price'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter product Unit Price!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _quantityController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity',
                        hintText: 'product quantity'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter product quantity!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _totalPriceController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Total',
                        hintText: 'Total price'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter total price!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                /*Card(
                  elevation: 7,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _createdDateController,
                    keyboardType:TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date',
                        hintText: 'product date time'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Write your Enter product date time!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),*/
                Visibility(
                  visible: _inProgress==false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _postProductList();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Product add Successfully!')));
                      Navigator.pop(context,true);
                    }
                  }, child: const Text('Save')),
                )
              ],
            )
        );
  }
}
