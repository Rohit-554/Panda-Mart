import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CategoryChoosePage extends StatefulWidget {

  const CategoryChoosePage({super.key});

  @override
  State<CategoryChoosePage> createState() => _CategoryChoosePageState();
}

class _CategoryChoosePageState extends State<CategoryChoosePage> {
  final GlobalKey<CarouselSliderState> carouselSliderKey = GlobalKey<CarouselSliderState>();

  int _currentIndex = 0;

  final List<String> carouselItems = ["Beauty", "Furniture","Food & Beverages", "Furniture", "Food & Beverages"];

  final List<String> categories = [
    "Beauty",
    "Chairs",
    "Groceries",
    "Category 4",
    "Category 5",
  ];

  final List<String> imagePaths = [
    'assets/images/beauty.png',
    'assets/images/bed.png',
    'assets/images/fruits.png',
    'assets/images/game_chair.png',
    'assets/images/cooking.png',
  ];

  final List<String> logoPaths = [
    'assets/images/beautylogo.png',
    'assets/images/chairlogo.png',
    'assets/images/grocerieslogo.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panda Mart'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CarouselSlider.builder(
              key: carouselSliderKey,
              itemCount: carouselItems.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/productPage',
                        arguments: carouselItems[index]);
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          imagePaths[index % imagePaths.length],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  _currentIndex = index;
                },
              ),
            ),
          ),

          // Indicator Section
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselItems.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    carouselSliderKey.currentState!.pageController?.jumpToPage(entry.key);
                  },
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Select a Category to start Exploring',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(logoPaths.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.pushNamed(context, '/productPage', arguments: 'Beauty');
                                break;
                              case 1:
                                Navigator.pushNamed(context, '/productPage', arguments: 'Furniture');
                                break;
                              case 2:
                                Navigator.pushNamed(context, '/productPage', arguments: 'Food & Beverages');
                                break;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(logoPaths[index]),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  categories[index],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Center(
                          child: Lottie.asset('assets/lotie/panda_moving.json', height: 200, width: 200),
                        ),
                        Text(
                          'Panda Mart `♡´',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}