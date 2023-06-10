import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:question_answear_app/constansts.dart';
import 'package:question_answear_app/core/helper/helper_function.dart';
import 'package:question_answear_app/core/presentation/font_manager.dart';
import 'package:question_answear_app/core/widget/app_bar.dart';
import 'package:question_answear_app/core/widget/bubble_widget.dart';
import 'package:question_answear_app/core/widget/custom_elevated_button.dart';
import 'package:question_answear_app/core/widget/preview_widget.dart';
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
            appBar:
                CustomAppBar(title: controller.section?.name ?? "", actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  controller.isEditingAnswer = !controller.isEditingAnswer;
                  controller.setAnswer(controller.answers
                      .firstWhere((element) => element.isValid == 1));
                  controller.update();
                },
              )
            ]),
            body: GetBuilder<QuestionClientController>(builder: (context) {
              return controller.items.isNotEmpty
                  ? controller.showResult
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "نتيجة الاختبار",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                            SizedBox(height: 40),
                            PieChart(
                              dataMap: controller.dataMap,
                              animationDuration: Duration(milliseconds: 800),
                              chartLegendSpacing: 42,
                              chartRadius: Get.width / 3.2,
                              colorList: [Colors.green, Colors.red],
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 32,
                              // totalValue: controller.items.length.toDouble(),
                              centerText: controller.items.length.toString(),
                              centerTextStyle:
                                  TextStyle(fontSize: 22, color: primaryColor),
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.top,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                decimalPlaces: 0,
                              ),
                              // gradientList: ---To add gradient colors---
                              // emptyColorGradient: ---Empty Color gradient---
                            ),
                          ],
                        )
                      : Stack(
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
                                                color: primaryColor
                                                    .withOpacity(0.3),
                                                offset: const Offset(0, 1),
                                                blurRadius: 20,
                                                spreadRadius: 1)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 30),
                                              Text(
                                                "Question ${controller.indexQuestion + 1} / ${controller.items.length}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10),
                                              InkWell(
                                                onTap: () => Get.dialog(
                                                    previewImage(controller
                                                        .items[controller
                                                            .indexQuestion]
                                                        .photo)),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      height: 110,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: controller
                                                                    .items[controller
                                                                        .indexQuestion]
                                                                    .photo ==
                                                                null
                                                            ? null
                                                            : DecorationImage(
                                                                image: FileImage(
                                                                    File(controller
                                                                        .items[controller
                                                                            .indexQuestion]
                                                                        .photo!)),
                                                                fit: BoxFit
                                                                    .fill),
                                                      ),
                                                      child: controller
                                                                  .items[controller
                                                                      .indexQuestion]
                                                                  .photo !=
                                                              null
                                                          ? SizedBox()
                                                          : Center(
                                                              child: Icon(
                                                              Icons
                                                                  .image_outlined,
                                                              color:
                                                                  Colors.grey,
                                                              size: 40,
                                                            )),
                                                    ),
                                                    Positioned(
                                                      top: -25,
                                                      right: -35,
                                                      child: RawMaterialButton(
                                                        hoverElevation: 0,
                                                        highlightElevation: 0,
                                                        hoverColor: Colors
                                                            .grey.shade100,
                                                        onPressed: () {
                                                          controller
                                                              .updateImageQuestion(
                                                                  controller
                                                                          .items[
                                                                      controller
                                                                          .indexQuestion]);
                                                        },
                                                        elevation: 0,
                                                        fillColor: Colors
                                                            .grey.shade200,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        shape:
                                                            const CircleBorder(),
                                                        child: const Icon(
                                                            Icons.edit,
                                                            size: 20.0,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    // Positioned(
                                                    //   top: -15,
                                                    //   right: -15,
                                                    //   child: GestureDetector(
                                                    //     onTap: () {
                                                    //       controller
                                                    //           .updateImageQuestion(
                                                    //               controller
                                                    //                       .items[
                                                    //                   controller
                                                    //                       .indexQuestion]);
                                                    //     },
                                                    //     child: Container(
                                                    //       height: 35,
                                                    //       width: 40,
                                                    //       decoration:
                                                    //           BoxDecoration(
                                                    //               shape: BoxShape
                                                    //                   .circle,
                                                    //               color: Colors
                                                    //                   .green
                                                    //                   .shade100),
                                                    //       child: const Center(
                                                    //         child: Icon(
                                                    //           Icons.edit,
                                                    //           color:
                                                    //               Colors.green,
                                                    //           size: 18,
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // )
                                                  ],
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
                                                    color:
                                                        Colors.grey.shade800),
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
                                              border: getBorder(e,
                                                  controller.selectedAnswer)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                14, 8, 14, 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                controller.checkIsImage(e.name)
                                                    ? InkWell(
                                                        onTap: () => Get.dialog(
                                                            previewImage(
                                                                e.name)),
                                                        child:
                                                            InteractiveViewer(
                                                          child: Container(
                                                            height: 70,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: FileImage(File((e.name ??
                                                                            "")
                                                                        .startsWith(
                                                                            "http")
                                                                    ? ""
                                                                    : e.name ??
                                                                        "")),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: Text(
                                                            e.name ?? "",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .grey
                                                                    .shade800)),
                                                      ),
                                                const SizedBox(width: 4),
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: Center(
                                                      child: controller
                                                              .isEditingAnswer
                                                          ? InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .updateImageAnswer(
                                                                        e);
                                                              },
                                                              child: const Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .green),
                                                            )
                                                          : getIcon(
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
                                                    iconData:
                                                        Icons.arrow_back_ios,
                                                    onPressed: () {
                                                      if (controller
                                                              .indexQuestion >
                                                          0) {
                                                        controller
                                                                .indexQuestion =
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
                                                    foregroundColor:
                                                        Colors.white,
                                                    onPressed: () {
                                                      if (controller.items
                                                                  .length -
                                                              1 >
                                                          controller
                                                              .indexQuestion) {
                                                        controller
                                                                .indexQuestion =
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
                                const SizedBox(height: 20)
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
