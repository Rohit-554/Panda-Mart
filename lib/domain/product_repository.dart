import 'package:panda_mart/data/model/product_model.dart';

import '../core/resources/data_state.dart';

abstract class ProductRepository {
  Future<DataState<List<Product>>> fetchProducts();
}
