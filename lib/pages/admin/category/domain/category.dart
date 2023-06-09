import '../../../../dbhelper.dart';

const String idCategory = "id";
const String nameCategory = "name";
const String tableCategories = 'categories';

class Category {
  int? id;
  String? name;
  int? sectionCount;
  Category({
    this.id,
    this.name,
  });

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    sectionCount = map['section_count'];
  }

  Map<String, dynamic> toMap() {
    return {
      idCategory: id,
      nameCategory: name,
    };
  }
}
