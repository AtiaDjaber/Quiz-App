const String idSection = "id";
const String nameSection = "name";
const String progressSection = "progress";
const String categoryIdSection = "categories_id";
const String indexLastQuestionSection = "index_last_question";
const String tableSections = 'sections';

class Section {
  int? id;
  String? name;
  int? categoryId;
  double? progress;
  int? questionCount;
  int? indexLastQuestion;
  Section(
      {this.id,
      this.name,
      this.indexLastQuestion,
      this.questionCount,
      this.categoryId});

  Section.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    progress = double.tryParse(map['progress']);
    categoryId = map['categories_id'];
    questionCount = map['question_count'];
    indexLastQuestion = map[indexLastQuestionSection];
  }

  Map<String, dynamic> toMap() {
    return {
      idSection: id,
      nameSection: name,
      progressSection: progress,
      categoryIdSection: categoryId,
      indexLastQuestionSection: indexLastQuestion
    };
  }
}
