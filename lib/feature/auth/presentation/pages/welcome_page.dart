import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/app_images.dart';

import '../../../../core/app_theme/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.girl),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 358,
              padding: const EdgeInsets.only(top: 31, left: 16, right: 16),
              decoration: const BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: const ContainerBody(),
            ),
          )
        ],
      ),
    );
  }
}

class ContainerBody extends StatelessWidget {
  const ContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 27,
        ),
        SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 55, left: 33),
                  child: Image.asset(AppImages.google),
                ),
                Text('Continue with Google',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              colors: [AppColors.beginColor, AppColors.endColor],
            ),
          ),
          child: const Icon(Icons.person),
        )
      ],
    );
  }
}
