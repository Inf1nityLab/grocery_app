import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: PageView.builder(
          itemCount: splashScreenData.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(splashScreenData[index].image),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.vector),
                      )
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class SplashScreenData {
  final String image;
  final String title;
  final String description;

  SplashScreenData(
      {required this.image, required this.title, required this.description});
}

List<SplashScreenData> splashScreenData = <SplashScreenData>[
  SplashScreenData(
      image: AppImages.splash1,
      title: 'Premium Food\nAt Your Doorstep',
      description:
          'Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy'),
  SplashScreenData(
      image: AppImages.splash2,
      title: 'Buy Premium\nQuality Fruits',
      description:
          'Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy'),
  SplashScreenData(
      image: AppImages.splash3,
      title: 'Buy Quality\nDairy Products',
      description:
          'Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy'),
  SplashScreenData(
      image: AppImages.splash4,
      title: 'Get Discounts\nOn All Products',
      description:
          'Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy'),
];
