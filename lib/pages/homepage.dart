import 'package:flutter/material.dart';
import 'package:news_app/component/category_card.dart';
import 'package:news_app/component/list_card.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/services/news_service.dart';
import '../model/article_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> items = [
    CategoryModel(text: 'business', image: 'assets/business.avif'),
    CategoryModel(text: 'general', image: 'assets/general.avif'),
    CategoryModel(text: 'health', image: 'assets/health.avif'),
    CategoryModel(text: 'sports', image: 'assets/sports.avif'),
    CategoryModel(text: 'entertainment', image: 'assets/entertaiment.avif'),
    CategoryModel(text: 'science', image: 'assets/science.avif'),
    CategoryModel(text: 'technology', image: 'assets/technology.jpeg'),

  ];


  var future;

  @override
  void initState() {
    future=NewsService().getNews(category:"general");
    super.initState();
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
          FutureBuilder(
              future:future ,
              builder: (context, AsyncSnapshot<List<ArticleModel>> snapshot) {
                if (snapshot.hasData) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: snapshot.data!.length,
                              (context,i) {
                    return ListCard(articleModel: snapshot.data![i]);
                  }));
                } else if (snapshot.hasError) {
                  return const SliverToBoxAdapter(child: Text("error"));
                }
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              }),
        ],
      ),
    ));
  }
}
