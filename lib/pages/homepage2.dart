//...... دي هستعملها لو مستخدمتش (مكان)ال future builder حيث بتكون بديله لها لكن بالطبع ال future افضل   ......

import 'package:flutter/material.dart';
import 'package:news_app/component/category_card.dart';
import 'package:news_app/component/list_card.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/services/news_service.dart';
import '../model/article_model.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  List<CategoryModel> items = [
    CategoryModel(text: 'business', image: 'assets/business.avif'),
    CategoryModel(text: 'general', image: 'assets/general.avif'),
    CategoryModel(text: 'health', image: 'assets/health.avif'),
    CategoryModel(text: 'sports', image: 'assets/sports.avif'),
    CategoryModel(text: 'entertaiment', image: 'assets/entertaiment.avif'),
    CategoryModel(text: 'science', image: 'assets/science.avif'),
  ];

  bool isLoading = false;

  List<ArticleModel> article = [];

  @override
  void initState() {
    GetNewsGeneral();
    super.initState();
  }

  Future<void> GetNewsGeneral() async {
    article = await NewsService().getNews(category: "general");
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          // كده انا بقوله خد مساحه بتاع ال children بس ملكش دعوه بالعرض كامل
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "News ",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            Text(
              "Cloud",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
          ],
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                  padding: const EdgeInsets.all(6),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(cards: items[index]);
                  }),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          isLoading == true
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: article.length, (context, i) {
                  return ListCard(
                    articleModel: article[i],
                  );
                }))
              : const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator())),
        ],
      ),
    ));
  }
}
