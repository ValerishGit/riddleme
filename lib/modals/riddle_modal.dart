// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riddle_me/modals/user_modal.dart';

class DailyQuestion {
  final String? question;
  final List<Answer>? answers;
  final List<UserClass>? answeredUsers;
  DailyQuestion(this.question, this.answers, this.answeredUsers);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answers': answers?.map((x) => x.toMap()).toList(),
      'answeredUsers': answeredUsers?.map((x) => x.toMap()).toList(),
    };
  }

  factory DailyQuestion.fromMap(Map<String, dynamic> map) {
    return DailyQuestion(
      map['question'] as String,
      List<Answer>.from(
        (map['answers'] as List<dynamic>).map<Answer>(
          (x) => Answer.fromMap(x as Map<String, dynamic>),
        ),
      ),
      List<UserClass>.from(
        (map['answeredUsers'] as List<dynamic>).map<UserClass>(
          (x) => UserClass.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyQuestion.fromJson(String source) =>
      DailyQuestion.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Answer {
  final String answer;
  final bool isCorrect;

  Answer(this.answer, this.isCorrect);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answer': answer,
      'isCorrect': isCorrect,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      map['answer'] as String,
      map['isCorrect'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);
}
