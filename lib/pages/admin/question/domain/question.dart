import 'dart:ffi';

const String idQuestion = "id";
const String nameQuestion = "name";
const String answeredQuestion = "answered";
const String sectionIdQuestion = "sections_id";
const String tableQuestions = 'questions';

class Question {
  int? id;
  String? name;
  int? sectionId;
  int? answered;
  List<Answer>? answers = [];
  Question({this.id, this.name, this.answered, this.sectionId, this.answers});

  Question.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    answered = map['answered'];
    sectionId = map['sections_id'];
  }

  Map<String, dynamic> toMap() {
    return {
      idQuestion: id,
      nameQuestion: name,
      answeredQuestion: answered,
      sectionIdQuestion: sectionId,
    };
  }
}

const String idAnswer = "id";
const String nameAnswer = "name";
const String isValidAnswer = "is_valid";
const String questionIdAnswer = "questions_id";
const String tableAnswers = 'answers';

class Answer {
  int? id;
  String? name;
  int? questionId;
  int? isValid;
  Answer({this.id, this.name, this.isValid, this.questionId});

  Answer.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    isValid = map['is_valid'];
    questionId = map['questions_id'];
  }

  Map<String, dynamic> toMap() {
    return {
      idQuestion: id,
      nameQuestion: name,
      isValidAnswer: isValid,
      questionIdAnswer: questionId,
    };
  }
}
