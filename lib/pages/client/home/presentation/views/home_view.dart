import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/constansts.dart';
import 'package:question_answear_app/core/presentation/font_manager.dart';
import 'package:question_answear_app/core/widget/app_bar.dart';
import 'package:question_answear_app/pages/admin/category/domain/category.dart';
import 'package:question_answear_app/pages/admin/category/presentation/views/category_view.dart';
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
        backgroundColor: backgroundColor,
        appBar: const CustomAppBar(title: "الدورات"),
        body: GetBuilder<HomeController>(builder: (_) {
          return controller.currentIndex == 0
              ? ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.toNamed(AppRoutes.sectionClient,
                          arguments: controller.items[index]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.items[index].name ?? "",
                                style: FontManager.primaryStyle,
                              )),
                        ),
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
