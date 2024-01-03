import 'package:flutter/material.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/pages/category_page.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key,required this.cards});

  final CategoryModel cards;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
         CategoryPage(catselect: cards.text),));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          image: DecorationImage(image: AssetImage(cards.image), fit: BoxFit.fill),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 190,
        child: Center(
          child: Text(
            cards.text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),
      ),
    );
  }
}



//....................
//لا يمكن استعمال ال widget دي لانها لا تدعم ال context حيث يجب استعمال ال class لانه يحتوي علي context لاستخدامه مع ال botton
//......................
// Widget CategoryCard({required CategoryModel cards}) {
//   return GestureDetector(
//     onTap: (){
//       Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(),));
//     },
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(6)),
//         image: DecorationImage(image: AssetImage(cards.image), fit: BoxFit.fill),
//       ),
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       width: 190,
//       child: Center(
//         child: Text(
//           cards.text,
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
//         ),
//       ),
//     ),
//   );
// }
