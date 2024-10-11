import 'package:dio/dio.dart';

import '../../core/resources/data_state.dart';
import '../../domain/product_repository.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService productService;

  ProductRepositoryImpl(this.productService);

  @override
  Future<DataState<List<Product>>> fetchProducts() async {
    try {
      final products = await productService.fetchProducts();
      return DataSuccess(products);
    } catch (e) {
      return DataFailed(e);
    }
  }
}
