// دي الصفحه الخاصه بال Methods لاستدعاء البيانات من api
//وده عصب اي تطبيق هتشتغل عليه في المستقبل ولازم هتحتاج الmethod دي
//وحيث ال method دي اعيد استخدمها في اي مكان عادي

import 'package:dio/dio.dart';
import 'package:news_app/model/article_model.dart';

class NewsService {
  final dio = Dio();

  Future<List<  ArticleModel>> getNews({required String category}) async {
    try {
      final response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=e944cf7629554ce68d88451d75b64bae');
      var jsonData = response.data;

      List article = jsonData['articles'];
      List<ArticleModel> articleList = [];

      for (int i = 0; i < article.length; i++) {
        ArticleModel articleModel = ArticleModel.fromjson(article[i]);
        //بديله لو مستعملتش ArticleModel.fromjson .........
        // ArticleModel(
        //     image: article[i]["urlToImage"],
        //     title: article[i]["title"],
        //     subtitle: article[i]["description"]);

        articleList.add(articleModel);
      }
      return articleList;
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] ?? "oops there was an error,try later";
      throw Exception(errorMessage);
    }
  }
}
