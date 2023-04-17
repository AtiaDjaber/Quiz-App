import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/constansts.dart';
import 'package:question_answear_app/core/presentation/font_manager.dart';
import 'package:question_answear_app/core/widget/app_bar.dart';
import 'package:question_answear_app/core/widget/bubble_widget.dart';
import 'package:question_answear_app/pages/admin/category/domain/category.dart';
import 'package:question_answear_app/pages/client/home/presentation/controllers/home_controller.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:question_answear_app/routes/app_routes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../controllers/section_client_controller.dart';

class SectionClientView extends GetView<SectionClientController> {
  const SectionClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: LayoutBuilder(builder: (context, constraints) {
              return GetBuilder<SectionClientController>(builder: (_) {
                return Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(color: primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: backgroundColor,
                                        shape: BoxShape.circle),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                FittedBox(
                                  child: Text(
                                    (controller.category?.name ?? ""),
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
                          top: 130,
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
                          return buildCard(index);
                        },
                      ),
                    ),
                  ],
                );
              });
            })),
      ),
    );
  }

  InkWell buildCard(int index) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.questionClient,
          arguments: controller.items[index]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.items[index].name ?? "",
                style: FontManager.primaryStyle,
              ),
            )),
      ),
    );
  }
}
