import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Model/product_model.dart';
import '../Widgets/product_items.dart';
import 'package:http/http.dart';

import 'add_product.dart';
class ProductLauncher extends StatefulWidget {
  const ProductLauncher({super.key});
  static const String routeName='/';

  @override
  State<ProductLauncher> createState() => _ProductLauncherState();
}

class _ProductLauncherState extends State<ProductLauncher> {

  List<ProductModel> productList=[];
  final bool _inProgress = false;

@override
  void initState() {
    // TODO: implement initState
  _getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Launcher'),
        backgroundColor: Colors.lime,
      ),
      body:RefreshIndicator(
        onRefresh: ()async{
          _getProductList();
        },
        child: Visibility(
          visible: _inProgress==false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: productList.length,
              itemBuilder: (context,index){
              return ProductItems(
                productModel: productList[index],
              );
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.pushNamed(context,AddProduct.routeName);
          },
        label: const Text('Add Product'),
       // icon: const Icon(Icons.add),

      ),
    );
  }

  Future<void> _getProductList()async{

  productList.clear();
  _inProgress==true;
  setState(() {});

    Uri uri =Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response= await get(uri);
    if(response.statusCode==200){
      final dataDecode=jsonDecode(response.body);
      for(Map<String,dynamic> p in dataDecode['data']){
        ProductModel productModel=ProductModel(
          id: p['_id'],
            productName:p['ProductName'],
            productCode:p['ProductCode'],
            img:p['Img'],
            unitPrice:p['UnitPrice'],
            qty:p['Qty'],
            totalPrice:p['TotalPrice'],
            createdDate:p['CreatedDate'],
        );
        productList.add(productModel);
        setState(() {});
    /*    print(response.statusCode);
        print(response.body);*/
      }
      _inProgress==false;
      setState(() {});
    }
  }


}


