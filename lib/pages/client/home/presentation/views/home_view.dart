import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/constansts.dart';
import 'package:question_answear_app/core/presentation/font_manager.dart';
import 'package:question_answear_app/core/widget/app_bar.dart';
import 'package:question_answear_app/core/widget/bubble_widget.dart';
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
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: LayoutBuilder(builder: (context, con) {
            return GetBuilder<HomeController>(builder: (_) {
              return controller.currentIndex == 0
                  ? Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(color: primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    FittedBox(
                                      child: Text(
                                        ("الدورات"),
                                        style: TextStyle(
                                            fontSize: FontManager.primarySize,
                                            color: backgroundColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Positioned(
                                bottom: -20, right: -30, child: BubbleWidget()),
                            const Positioned(
                                bottom: -100,
                                left: -30,
                                child: BubbleWidget(width: 100, height: 250)),
                            const Positioned(
                                top: -100,
                                left: -30,
                                child: BubbleWidget(width: 170, height: 150)),
                            Positioned(
                              top: 110,
                              height: Get.height,
                              width: Get.width,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.items.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.toNamed(
                                    AppRoutes.sectionClient,
                                    arguments: controller.items[index]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 0,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.items[index].name ??
                                                  "",
                                              style: FontManager.primaryStyle,
                                            ),
                                            Text.rich(
                                              TextSpan(children: [
                                                TextSpan(
                                                    text: "عدد الأقسام",
                                                    style:
                                                        FontManager.spanStyle),
                                                TextSpan(
                                                    text:
                                                        " ${controller.items[index].sectionCount}",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const CategoryView();
            });
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
                  icon: Icon(Icons.home_outlined),
                  title: Text("Home"),
                  selectedColor: Colors.purple,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: Icon(Icons.category_outlined),
                  title: Text("دورات"),
                  selectedColor: Colors.pink,
                ),

                /// Search
                SalomonBottomBarItem(
                  icon: Icon(Icons.search),
                  title: Text("Search"),
                  selectedColor: Colors.orange,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
