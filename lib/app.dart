import 'package:flutter/material.dart';
import 'package:untitled/Model/product_model.dart';
import 'package:untitled/UI/Screen/add_product.dart';
import 'package:untitled/UI/Screen/product_launcher.dart';
import 'package:untitled/UI/Screen/update_product.dart';
import 'UI/Screen/delete_product.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ProductLauncher.routeName,
      onGenerateRoute: (RouteSettings settings) {
        Widget widget;

        if (settings.name == ProductLauncher.routeName) {
          widget = const ProductLauncher();
        } else if (settings.name == AddProduct.routeName) {
          widget = const AddProduct();
        } else if (settings.name == UpdateProduct.routeName) {
          final ProductModel productModel = settings.arguments as ProductModel;
          widget = UpdateProduct(productModel: productModel);
        } else if (settings.name == DeleteProduct.routeName) {
          final ProductModel productModel = settings.arguments as ProductModel;
          widget = DeleteProduct(productModel: productModel);
        } else {
          // Fallback widget for undefined routes
          widget = const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        );
      },
    );
  }
}
