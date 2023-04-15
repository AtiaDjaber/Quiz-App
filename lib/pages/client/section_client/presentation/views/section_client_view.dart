import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                  title: const Text("الأقسام", style: TextStyle(fontSize: 22))),
              body: GetBuilder<SectionClientController>(builder: (context) {
                return ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.toNamed(AppRoutes.questionClient,
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
                );
              })),
        ));
  }

  Widget buildCard(int index, Section section, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                section.name ?? "",
                maxLines: 4,
                softWrap: true,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
