import 'package:question_answear_app/dbhelper.dart';
import 'package:question_answear_app/pages/section/domain/section.dart';

abstract class SectionRepository {
  Future<List<Section>> getData(String tableName);
}

class SectionRepositoryImp extends SectionRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Section>> getData(String tableName) async {
    List<Section> items = [];
    var data = await dbHelper.queryData(tableName);
    for (var row in data) {
      Section cli = Section.fromMap(row);
      items.add(cli);
    }
    return items;
  }
}
