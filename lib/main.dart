import 'package:flutter/material.dart';

// void main() => runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => const MyApp(),
//   ),
// );
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<ProductBloc>(
//           create: (context) => ProductBloc(ProductRepositoryImpl(ProductLocalDataSource()))
//             ..add(LoadProducts()),
//         ),
//         // Другие BlocProviders, если необходимо
//       ],
//       child: MaterialApp(
//         useInheritedMediaQuery: true,
//         locale: DevicePreview.locale(context),
//         builder: DevicePreview.appBuilder,
//         theme: ThemeData.light(),
//         darkTheme: ThemeData.dark(),
//         home: const ProductListScreen(),
//       ),
//     );
//   }
// }

// Остальная часть кода остается без изменений...

import 'package:flutter/material.dart';

import 'feature/home/presentation/home_page.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Передаем общий dataSource в ProductListScreen
      home:  const CartScreen(),
    );
  }
}

