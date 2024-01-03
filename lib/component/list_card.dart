import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';



Widget ListCard({required ArticleModel articleModel}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(articleModel.image ??
                  "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        height: 200,
      ),
      Text(
        "${articleModel.title}",
        style: TextStyle(fontSize: 20),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        articleModel.subtitle ?? "",
        style: TextStyle(fontSize: 15),
      ),
      SizedBox(
        height: 15,
      ),
    ]),
  );
}
