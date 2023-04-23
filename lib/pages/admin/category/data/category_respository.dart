import 'package:question_answear_app/dbhelper.dart';
import 'package:question_answear_app/pages/admin/category/domain/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getData(String tableName);
  Future<List<Category>> getDataWithCount(String tableName);
  Future<int> insert(String tableName, Map<String, dynamic> row);
}

class CategoryRepositoryImp extends CategoryRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Category>> getData(String tableName) async {
    List<Category> items = [];
    var data = await dbHelper.queryData(tableName);
    for (var row in data) {
      Category cli = Category.fromMap(row);
      items.add(cli);
    }
    return items;
  }

  @override
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    return await dbHelper.insert(tableName, row);
  }

  @override
  Future<List<Category>> getDataWithCount(String tableName) async {
    List<Category> items = [];
    var data = await dbHelper.queryCategoriesWithCountSection();
    for (var row in data) {
      Category cli = Category.fromMap(row);
      items.add(cli);
    }
    return items;
  }
}
