import 'package:dio/dio.dart';
import 'package:dio_api_calling/model.dart';

class ProductService {
  final Dio dio = Dio();

  Future<List<Product>> getProducts() async {
    try {
      Response response = await dio.get('https://dummyjson.com/products');
      if (response.statusCode == 200) {
        List<Product> products = (response.data['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      Response response = await dio.put('https://dummyjson.com/products/${product.id}', data: product.toJson());
      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      Response response = await dio.delete('https://dummyjson.com/products/$productId');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      Response response = await dio.post('https://dummyjson.com/products', data: product.toJson());
      if (response.statusCode != 201) {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }
}
