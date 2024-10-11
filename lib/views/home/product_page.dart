import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:panda_mart/data/model/product_model.dart';
import 'package:panda_mart/data/service/FirebaseRemoteConfigService.dart';
import 'package:panda_mart/views/widgets/AddToCartButton.dart';
import 'package:provider/provider.dart';
import '../viewModels/product_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../viewModels/remote_config_viewmodel.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key,this.category});

  final String? category;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var shouldShowDiscountPrice = false;
  var _isLoading = false;
  final _remoteConfig = FirebaseRemoteConfig.instance;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProducts(widget.category ?? 'Beauty');
    });
    _initRemoteConfig();
  }

  _initRemoteConfig() async{
    setState(() {
      _isLoading = false;
    });
    await _remoteConfig.setDefaults(const{
      "IsDiscount" : true,
      "shouldShowDiscountedPrice" : false
    });
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 10),
    ));
    await _remoteConfig.fetchAndActivate();
    shouldShowDiscountPrice = _remoteConfig.getBool("IsDiscount");
    _remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
      await _remoteConfig.activate();
      setState(() {
        shouldShowDiscountPrice = _remoteConfig.getBool("IsDiscount");
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  void _fetchProducts(String category) {
    final viewModel = context.read<ProductViewModel>();
    viewModel.fetchProducts(category);
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.error != null
              ? Center(child: Text('Error: ${viewModel.error}'))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items in a row
                    childAspectRatio:
                        0.6, // Adjust the aspect ratio for card height
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: viewModel.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = viewModel.products![index];
                    return ProductItemLayout(product: product, viewModel: viewModel, shouldShowDiscountPrice: shouldShowDiscountPrice,);
                  },
                ),
    );
  }
}

class ProductItemLayout extends StatelessWidget {
  const ProductItemLayout({
    super.key,
    required this.product,
    required this.viewModel,
    required this.shouldShowDiscountPrice,
  });

  final Product product;
  final ProductViewModel viewModel;
  final bool shouldShowDiscountPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: product.thumbnail ?? 'https://bit.ly/481c7nY',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
              placeholder: (context, url) =>
                  Center(
                    child: Lottie.asset('assets/lotie/loading.json'),
                  ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error), // Show error icon if image fails to load
            ),
          ),


          // Product Title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 2, // Limit title to 2 lines
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Price and Rating
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Display star rating
                    Text(
                      '${product.rating}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    const Icon(Icons.star_border, size: 16),
                    const SizedBox(width: 4),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              shouldShowDiscountPrice
                  ? showDiscountedPrice(product)
                  : '\$${product.price!.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 16,
              ),
            ),
          ),
          // Add to Cart Button
          Spacer(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddToCartButton(
                  isLoading: false, text: "Add to cart", onPressed: () {})
          ),
        ],
      ),
    );
  }

  String showDiscountedPrice(Product product) {
    if (product.discountPercentage != null) {
      final discountedPrice = product.price! -
          (product.price! * product.discountPercentage! / 100);
      return '\$${discountedPrice.toStringAsFixed(2)}';
    } else {
      return '';
    }
  }
}



