import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../core/resources/data_state.dart';
import '../../core/utils/others.dart';
import '../../data/model/product_model.dart';
import '../usecases/firebase_remote_config.dart';
import '../usecases/use_cases.dart';

class ProductViewModel extends ChangeNotifier {
  final FetchProductsUseCase fetchProductsUseCase;
  final FetchRemoteConfigUseCase getDiscountedPriceUseCase;

  ProductViewModel(this.fetchProductsUseCase, this.getDiscountedPriceUseCase);

  List<Product>? _products;
  String? _error;
  bool _isLoading = false;
  List<String>? _tags;

  List<Product>? get products => _products;

  String? get error => _error;

  bool get isLoading => _isLoading;

  List<String>? get tags => _tags;


  Future<void> fetchProducts(String category) async {
    _isLoading = true;
    notifyListeners();
    final result = await fetchProductsUseCase();
    getFcmToken();
    if (result is DataSuccess<List<Product>>) {
      _products = _filterProductsByCategory(result.data, category);
      print('Products: $_products');
      _error = null;
    } else if (result is DataFailed<List<Product>>) {
      _error = result.error.toString();
      _products = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> initconfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      var res = remoteConfig.getBool('shouldShowDiscountPrice');
      print('shouldShowDiscountPrice: ${res}');
      // Use the new config values here.
    });

  }


  Future<void> getFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      print("FCM Registration Token: $token");
    } catch (e) {
      print("Error retrieving FCM token: $e");
    }
  }

  void findDifferentTags(List<Product>? products) {
    final tags = <String>{};

    if (products != null) {
      for (var product in products!) {
        if (product.tags != null) {
          tags.addAll(product.tags!.toSet());
        }
      }
    }

    _tags = tags.toList();
    notifyListeners();
  }

  List<Product>? _filterProductsByCategory(
      List<Product>? products, String category) {

    if (products == null) return null;
    List<String> tagsToMatch;

    switch (category) {
      case 'Beauty':
        tagsToMatch = MajorTags.beautyProducts;
        break;
      case 'Furniture':
        tagsToMatch = MajorTags.furniture;
        break;
      case 'Food & Beverages':
        tagsToMatch = MajorTags.foodBeverages;
        break;
      default:
        return products;
    }
    final lowerCaseTagsToMatch = tagsToMatch.map((tag) => tag.toLowerCase()).toList();

    return products.where((product) {
      return product.tags?.any((tag) => lowerCaseTagsToMatch.contains(tag.toLowerCase())) ?? false;
    }).toList();
  }
}
