import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:question_answear_app/pages/category/domain/category.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("الدورات", style: TextStyle(fontSize: 22)),
            bottom: TabBar(
              controller: controller.tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blueAccent,
              labelStyle: TextStyle(fontSize: 22),
              unselectedLabelStyle: TextStyle(fontSize: 20),
              // indicator: BoxDecoration(
              //     borderRadius: BorderRadius.circular(50),
              //     color: Colors.amber[200]),
              tabs: [
                GetBuilder<CategoryController>(
                  builder: (_) {
                    return Tab(text: controller.editOrAdd);
                  },
                ),
                Tab(text: "قائمة الدورات")
              ],
            ),
          ),
          body: GetBuilder<CategoryController>(builder: (_) {
            return TabBarView(controller: controller.tabController, children: [
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 60),
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade100))),
                                        child: TextField(
                                          controller: controller.nameContr,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "ادخل إسم الدورة ",
                                              prefixIcon:
                                                  Icon(Icons.category_outlined),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (controller.editOrAdd == "إضافة") {
                                        controller.insertData();
                                      } else {
                                        controller.updateData(
                                            controller.selectedCategory);
                                      }
                                      controller.nameContr.text = "";
                                    },
                                    child: Text(
                                      controller.editOrAdd,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    color: Colors.blue,
                                    elevation: 4,
                                    minWidth: 200,
                                    height: 50,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                controller.editOrAdd == "تعديل"
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: MaterialButton(
                                          onPressed: () {
                                            controller.editOrAdd = "إضافة";
                                            controller.nameContr.text = "";
                                            controller.update();
                                          },
                                          child: Text(
                                            ' إلغاء ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          color: Colors.redAccent,
                                          elevation: 4,
                                          minWidth: 200,
                                          height: 50,
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Positioned(
                            // top:100,
                            // left: MediaQuery.of(context).size.width/2,

                            child: Center(),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              ListView(
                children: [
                  for (int index = 0;
                      index < controller.items.length;
                      index++) ...[
                    buildCard(index, controller.items[index], context)
                  ]
                ],
              ),
            ]);
          }),
        ),
      ),
    );
  }

  Widget buildCard(int index, Category category, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                category.name ?? "",
                maxLines: 4,
                softWrap: true,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              controller.editOrAdd = "تعديل";
              controller.selectedCategory = category;
              controller.nameContr.text = category.name ?? "";
              controller.update();
              controller.tabController.animateTo(0);
            },
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.green[50], shape: BoxShape.circle),
                child: const Icon(Icons.edit, color: Colors.green)),
          ),
        ),
      ]),
    );
  }

  showAlert() async {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
        side: BorderSide(
          color: Colors.blue,
        ),
      ),
      titleStyle: TextStyle(color: Colors.black87, fontSize: 20),
    );

    Alert(
        context: Get.context!,
        style: alertStyle,
        title: "تمت العملية بنجاح",
        buttons: [
          DialogButton(
            color: Colors.blue,
            onPressed: () => Get.back(),
            child: Text(
              "موافق",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
