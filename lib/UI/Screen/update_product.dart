import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../Model/product_model.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.productModel});
  static const String routeName='/update_product';

  final ProductModel productModel;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  @override
  void initState() {
    _productNameController.text=widget.productModel.productName??'';
    _productCodeController.text=widget.productModel.productCode??'';
    _imageController.text=widget.productModel.img??'';
    _unitPriceController.text=widget.productModel.unitPrice??'';
    _quantityController.text=widget.productModel.qty??'';
    _totalPriceController.text=widget.productModel.totalPrice??'';
  //  _createdDateController.text=widget.productModel.createdDate??'';
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _productNameController=TextEditingController();
  final TextEditingController _productCodeController=TextEditingController();
  final TextEditingController _imageController=TextEditingController();
  final TextEditingController _unitPriceController=TextEditingController();
  final TextEditingController _quantityController=TextEditingController();
  final TextEditingController _totalPriceController=TextEditingController();
  //final TextEditingController _createdDateController=TextEditingController();
   final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  final bool _inProgress=false;


  Future<void> _postProduct()async{
    _inProgress==true;
   // setState(() {});

    Uri uri =Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.productModel.id}');
    //
    Map<String,dynamic> responseBody = <String,dynamic>{
      'ProductName':_productNameController.text.trim(),
      'ProductCode':_productCodeController.text.trim(),
      'Img':_imageController.text.trim(),
      'UnitPrice':_unitPriceController.text.trim(),
      'Qty':_quantityController.text.trim(),
      'TotalPrice':_totalPriceController.text.trim(),
      //'createdDate':_createdDateController.text.trim(),
    };
    // Map<String,dynamic> responseBody = <String,dynamic>{
    //   "ProductName": "alamindaaaaa",
    //   "ProductCode": "45",
    //   "Img": "adsfsd",
    //   "UnitPrice": "200",
    //   "Qty": "2",
    //   "TotalPrice": "400"
    // };
    Response response= await post(
        uri,
      headers:
      {'Content-type':'application/json'},
      body: jsonEncode(responseBody)
    );

    print('-----response code:${response.statusCode}');
    if(!mounted) return;
    _inProgress==false;
    //setState(() {});


    if(response.statusCode==200){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Update successfully')
          )
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Update failed try again')
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Update Product')
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _updateForm(),
        ),
      )
    );
  }

  Form _updateForm() {
    return Form(
      key: _formKey,
            child: Column(
              children: [
                Card(
                  elevation: 7,
                  child: TextFormField(
                    controller: _productNameController,
                    decoration: const InputDecoration(
                      hintText: 'Product Name',
                      labelText: 'Name',
                      border:OutlineInputBorder()
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your product name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    controller: _productCodeController,
                    decoration: const InputDecoration(
                        hintText: 'Product Code',
                        labelText: 'Code',
                        border:OutlineInputBorder()
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your product code';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  elevation: 7,
                  child: TextFormField(

                    controller: _imageController,
                    keyboardType:TextInputType.url,
                    decoration: const InputDecoration(
                        hintText: 'Image Url',
                        labelText: 'Image',
                        border:OutlineInputBorder()
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter valid image url';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    controller: _unitPriceController,
                    keyboardType:TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Product Price',
                        labelText: 'Price',
                        border:OutlineInputBorder()
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your product price';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    controller: _quantityController,
                    keyboardType:TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Product Quantity',
                        labelText: 'Quantity',
                        border:OutlineInputBorder()
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your product quantity';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  elevation: 7,
                  child: TextFormField(
                    controller: _totalPriceController,
                    keyboardType:TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Total Price',
                        labelText: 'Total',
                        border:OutlineInputBorder()
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your product total price';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        await _postProduct();
                        Navigator.pop(context,true);
                      }
                    },
                    child: const Text('Update')
                )
              ],
            )
        );
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
    //_createdDateController.dispose();
    super.dispose();
  }
}
