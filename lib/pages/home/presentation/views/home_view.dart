import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/pages/category/domain/category.dart';
import 'package:question_answear_app/pages/category/presentation/views/category_view.dart';
import 'package:question_answear_app/routes/app_routes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GetBuilder<HomeController>(builder: (_) {
          return controller.currentIndex == 0
              ? ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.toNamed(AppRoutes.section,
                          arguments: controller.items[index]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: Text(
                          controller.items[index].name ?? "",
                          style: TextStyle(fontSize: 18),
                        )),
                      ),
                    );
                  },
                )
              : const CategoryView();
        }),
        bottomNavigationBar: GetBuilder<HomeController>(builder: (_) {
          return SalomonBottomBar(
            currentIndex: controller.currentIndex,
            onTap: (i) {
              controller.currentIndex = i;
              controller.update();
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Colors.purple,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text("دورات"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ],
          );
        }),
      ),
    );
  }
}
