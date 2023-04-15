import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/pages/admin/category/domain/category.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';
import 'package:question_answear_app/pages/client/home/presentation/controllers/home_controller.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:question_answear_app/routes/app_routes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../controllers/question_client_controller.dart';

class QuestionClientView extends GetView<QuestionClientController> {
  const QuestionClientView({super.key});

  @override
  Widget build(BuildContext context) {
    int count = controller.items.length;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: const Text("الأسئلة", style: TextStyle(fontSize: 22)),
              ),
              body: GetBuilder<QuestionClientController>(builder: (context) {
                return controller.items.length > 0
                    ? Column(
                        children: [
                          Text(
                            controller.items[controller.indexQuestion].name ??
                                "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 30),
                          ...controller.answers.map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(14, 4, 14, 4),
                                    child: Text(e.name ?? "",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: InkWell(
                                    onTap: () async {
                                      if (controller.position > 0) {
                                        controller.indexQuestion =
                                            controller.indexQuestion - 1;

                                        controller.position =
                                            controller.position - 1;
                                        controller.getAnswer(controller
                                            .items[controller.indexQuestion]
                                            .id!);
                                      }
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[200]),
                                      child: const Center(
                                        child: Icon(Icons.arrow_back_ios,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      " ${controller.indexQuestion} / ${controller.items.length}",
                                      style: TextStyle(fontSize: 14),
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: InkWell(
                                    onTap: () async {
                                      if (count - 1 > controller.position) {
                                        controller.indexQuestion =
                                            controller.indexQuestion + 1;

                                        controller.position =
                                            controller.position + 1;
                                        controller.getAnswer(controller
                                            .items[controller.indexQuestion]
                                            .id!);
                                      }
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[300],
                                      ),
                                      child: Center(
                                          child: Icon(Icons.arrow_forward_ios,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [],
                      );
                //  ListView.builder(
                //   itemCount: controller.items.length,
                //   itemBuilder: (context, index) {
                //     return InkWell(
                //       onTap: () => Get.toNamed(AppRoutes.question,
                //           arguments: controller.items[index]),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Card(
                //             child: Text(
                //           controller.items[index].name ?? "",
                //           style: TextStyle(fontSize: 18),
                //         )),
                //       ),
                //     );
                //   },
                // );
              })),
        ));
  }

  Widget buildCard(int index, Question question, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                question.name ?? "",
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
