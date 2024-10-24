import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchBody(),
                    const SizedBox(
                      height: 10,
                    ),
                    const BannerBody(),
                    const SizedBox(
                      height: 20,
                    ),
                    _textCategory(),
                    const SizedBox(height: 17,),
                    const CategoryBody(),
                    const SizedBox(height: 32,),
                    _featuredText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textCategory() {
    return const Text(
      'Categories',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _featuredText() {
    return const Text(
      'Featured Products',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}

class BannerBody extends StatelessWidget {
  const BannerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 283,
      color: Colors.red,
    );
  }
}

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
        return const Padding(
          padding:  EdgeInsets.only(right: 19),
          child:  Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Icon(Icons.fastfood, color: Colors.red,),
              ),
              SizedBox(height: 11,),
              Text('Name')
            ],
          ),
        );
      }),
    );
  }
}

class ListProductsBody extends StatelessWidget {
  const ListProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
