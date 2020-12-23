import 'package:flutter/material.dart';
import 'package:foodapp/fake_data.dart';
import 'package:foodapp/models/category.dart';
import 'package:foodapp/models/food.dart';

class FoodsPage extends StatelessWidget {
  static const String routeName = '/FoodsPage';
  Category category;
  FoodsPage({this.category});
  @override
  Widget build(BuildContext context) {
    Map<String, Category> arguments = ModalRoute.of(context).settings.arguments;
    this.category = arguments['category'];
    //Filter foods of from category
    List<Food> foods = FAKE_FOODS
        .where((food) => food.categoryId == this.category.id)
        .toList(); // điều kiện thỏa mãn
    return Scaffold(
      appBar: AppBar(
        title: Text('Foods from ${category.content}'),
      ),
      body: Center(
          child: Center(
        child: ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              Food food = foods[index];
              return Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.hardEdge,
                      child: Center(
                        child: FadeInImage.assetNetwork(
                            placeholder:
                                'assets/images/loading.gif', // ảnh khi mình loading
                            image: food.urlImage), // đường link đến cái ảnh đó
                      ),
                    ),
                  ),
                  Positioned(
                    // Đặt vị trí tuyện đối với Positioned của cái thẻ đó so với thẻ khác
                    top: 30,
                    left: 30,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            color: Colors.white,
                            size: 25,
                          ), // Icon hiện thời gian lấy từ fake_data
                          Text(
                            '${food.duration.inMinutes} minutes',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${food.complexity.toString().split('.').last}', // độ khó của món ăn
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${food.name}', // tên món ăn
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }),
      )),
    );
  }
}
