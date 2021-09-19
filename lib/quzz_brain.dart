import 'package:quizzler_flutter/question.dart';

class QuzzBrain {

  var questionNumber = 0;

  final questions = [
    Question(
        title: 'You can lead a cow down stairs but not up stairs.',
        answer: false),
    Question(
        title: 'Approximately one quarter of human bones are in the feet.',
        answer: true),
    Question(title: 'A slug\'s blood is green.', answer: true)
  ];

  void nextQuestion() {
    if (questionNumber < questions.length - 1) {
      questionNumber++;
    }
  }

  String getQuestionTitle() {
    return questions[questionNumber].title;
  }

  bool getCorrectAnswer() {
    return questions[questionNumber].answer;
  }

  bool isFinish() {
    return questionNumber >= (questions.length - 1);
  }

  void reset(){
    questionNumber = 0;
  }

}
