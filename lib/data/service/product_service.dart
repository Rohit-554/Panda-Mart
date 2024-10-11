import 'package:dio/dio.dart';
import '../model/product_model.dart';

class ProductService {
  final Dio _dio;

  ProductService(this._dio);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      final List productsJson = response.data['products'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
