import 'package:flutter/material.dart';

import '../component/list_card.dart';
import '../model/article_model.dart';
import '../services/news_service.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key,this.catselect});

  final String? catselect;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var future;

  @override
  void initState() {
    future = NewsService().getNews(category: widget.catselect!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<List<ArticleModel>> snapshot) {
                  if (snapshot.hasData) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: snapshot.data!.length, (context, i) {
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
      ),
    );
  }
}
