import 'package:question_answear_app/dbhelper.dart';
import 'package:question_answear_app/pages/section/domain/section.dart';

abstract class SectionRepository {
  Future<List<Section>> getData(int categoryId);
  Future<int> insert(Map<String, dynamic> row);
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
}