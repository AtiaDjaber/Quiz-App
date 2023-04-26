import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/constansts.dart';
import 'package:question_answear_app/core/helper/helper_function.dart';
import 'package:question_answear_app/core/presentation/font_manager.dart';
import 'package:question_answear_app/core/widget/app_bar.dart';
import 'package:question_answear_app/core/widget/bubble_widget.dart';
import 'package:question_answear_app/core/widget/custom_elevated_button.dart';
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
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: CustomAppBar(title: controller.section?.name ?? ""),
            body: GetBuilder<QuestionClientController>(builder: (context) {
              return controller.items.isNotEmpty
                  ? Stack(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        ),
                        ListView(
                          children: [
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  const Positioned(
                                      top: -50,
                                      left: -50,
                                      child: BubbleWidget()),
                                  const Positioned(
                                      top: -70,
                                      right: -70,
                                      child: BubbleWidget(
                                        width: 90,
                                      )),
                                  const Positioned(
                                      top: -100,
                                      right: 70,
                                      child: BubbleWidget(
                                        width: 40,
                                      )),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                primaryColor.withOpacity(0.3),
                                            offset: const Offset(0, 1),
                                            blurRadius: 20,
                                            spreadRadius: 1)
                                      ],
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Text(
                                          //       "8",
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(
                                          //           fontSize: 18,
                                          //           fontWeight: FontWeight.w600,
                                          //           color:
                                          //               Colors.grey.shade800),
                                          //     ),
                                          //     Text(
                                          //       "8",
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(
                                          //           fontSize: 18,
                                          //           fontWeight: FontWeight.w600,
                                          //           color:
                                          //               Colors.grey.shade800),
                                          //     )
                                          //   ],
                                          // ),

                                          const SizedBox(height: 30),
                                          Text(
                                            "Question ${controller.indexQuestion + 1} / ${controller.items.length}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          InkWell(
                                            onTap: () => controller.updateImage(
                                                controller.items[
                                                    controller.indexQuestion]),
                                            child: Container(
                                              height: 110,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: controller
                                                            .items[controller
                                                                .indexQuestion]
                                                            .photo ==
                                                        null
                                                    ? null
                                                    : DecorationImage(
                                                        image: FileImage(File(
                                                            controller
                                                                .items[controller
                                                                    .indexQuestion]
                                                                .photo!)),
                                                        fit: BoxFit.fill),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            controller
                                                    .items[controller
                                                        .indexQuestion]
                                                    .name ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade800),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -35,
                                    left: 10,
                                    right: 10,
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(
                                            value: controller.counter / 60,
                                            color: primaryColor,
                                            backgroundColor:
                                                Colors.grey.shade200,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -15,
                                    left: 10,
                                    right: 10,
                                    child: Container(
                                        width: 30,
                                        child: Center(
                                            child: Text(
                                          controller.counter.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: primaryColor),
                                        ))),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            ...controller.answers.map((e) => InkWell(
                                  onTap: () {
                                    controller.setAnswer(e);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: getBorder(
                                              e, controller.selectedAnswer)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14, 8, 14, 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(e.name ?? "",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors
                                                          .grey.shade800)),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Center(
                                                  child: getIcon(
                                                      e,
                                                      controller
                                                          .selectedAnswer)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            controller.selectedAnswer != null
                                ? Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        controller.indexQuestion > 0
                                            ? CustomElevatedButton(
                                                title: "السابق",
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                foregroundColor:
                                                    Colors.grey.shade700,
                                                iconData: Icons.arrow_back_ios,
                                                onPressed: () {
                                                  if (controller.indexQuestion >
                                                      0) {
                                                    controller.indexQuestion =
                                                        controller
                                                                .indexQuestion -
                                                            1;

                                                    controller.getAnswer(
                                                        controller
                                                            .items[controller
                                                                .indexQuestion]
                                                            .id!);
                                                  }
                                                },
                                              )
                                            : const SizedBox(),
                                        (controller.indexQuestion + 1) <
                                                controller.items.length
                                            ? CustomElevatedButton(
                                                title: "التالي",
                                                iconData:
                                                    Icons.arrow_forward_ios,
                                                foregroundColor: Colors.white,
                                                onPressed: () {
                                                  if (controller.items.length -
                                                          1 >
                                                      controller
                                                          .indexQuestion) {
                                                    controller.indexQuestion =
                                                        controller
                                                                .indexQuestion +
                                                            1;

                                                    controller.getAnswer(
                                                        controller
                                                            .items[controller
                                                                .indexQuestion]
                                                            .id!);
                                                  }
                                                },
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "لا توجد اسئلة",
                            style: FontManager.primaryStyle,
                          ),
                          const SizedBox(height: 20),
                          const Icon(
                            Icons.not_listed_location_sharp,
                            color: Colors.grey,
                            size: 42,
                          )
                        ],
                      ),
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
            })));
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
