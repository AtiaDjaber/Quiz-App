import 'package:question_answear_app/dbhelper.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';

abstract class SectionRepository {
  Future<List<Section>> getData(int categoryId);
  Future<List<Section>> getDataWithCount(int categoryId);
  Future<int> insert(Map<String, dynamic> row);
  Future<int> updateData(
      String tableName, Map<String, dynamic> map, List<dynamic> args);
}

class SectionRepositoryImp extends SectionRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Section>> getData(int categoryId) async {
    List<Section> items = [];
    var data = await dbHelper.queryData(tableSections,
        where: "categories_id = ?", argsWhere: [categoryId]);
    for (var row in data) {
      Section cli = Section.fromMap(row);
      items.add(cli);
    }
    return items;
  }

  @override
  Future<int> insert(Map<String, dynamic> row) async {
    return await dbHelper.insert(tableSections, row);
  }

  @override
  Future<List<Section>> getDataWithCount(int categoryId) async {
    List<Section> items = [];
    var data = await dbHelper.querySectionsWithCountQuestion(categoryId);
    for (var row in data) {
      Section cli = Section.fromMap(row);
      items.add(cli);
    }
    return items;
  }

  @override
  Future<int> updateData(
      String tableName, Map<String, dynamic> map, List args) async {
    return await dbHelper.update(tableName, map, args);
  }
}
