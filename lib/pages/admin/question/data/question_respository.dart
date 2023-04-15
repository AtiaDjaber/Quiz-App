import 'package:question_answear_app/dbhelper.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';

abstract class QuestionRepository {
  Future<List<Question>> getData(
      String tableName, String where, List<dynamic> args);
  Future<List<Answer>> getAnswer(
      String tableName, String where, List<dynamic> args);
  Future<int> insert(String tableName, Map<String, dynamic> row);
}

class QuestionRepositoryImp extends QuestionRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Question>> getData(
      String tableName, String where, List<dynamic> args) async {
    List<Question> items = [];
    var data =
        await dbHelper.queryData(tableName, where: where, argsWhere: args);
    for (var row in data) {
      Question cli = Question.fromMap(row);
      items.add(cli);
    }
    return items;
  }

  @override
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    return await dbHelper.insert(tableName, row);
  }

  @override
  Future<List<Answer>> getAnswer(
      String tableName, String where, List args) async {
    List<Answer> items = [];
    var data =
        await dbHelper.queryData(tableName, where: where, argsWhere: args);
    for (var row in data) {
      Answer cli = Answer.fromMap(row);
      items.add(cli);
    }
    return items;
  }
}
