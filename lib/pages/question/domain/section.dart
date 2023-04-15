const String idSection = "id";
const String nameSection = "name";
const String progressSection = "progress";
const String categoryIdSection = "categories_id";
const String tableSections = 'sections';

class Section {
  int? id;
  String? name;
  String? categoryId;

  Section({this.id, this.name, this.categoryId});

  Section.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    categoryId = map['categories_id'];
  }

  Map<String, dynamic> toMap() {
    return {
      idSection: id,
      nameSection: name,
      categoryIdSection: categoryId,
    };
  }
}
