import 'package:quizapp/model/questions_ans.dart';

class QuestionBank {
  List<QuestionAns> _questions = [
    QuestionAns('1.we have seven days  in a week', true),
    QuestionAns('2.There are 350 days ia a year', false),
    QuestionAns('3.There are seven colors in a rainbow', true),
    QuestionAns('4.There are 26 letters in the English alphabet', true),
  ];

  String getQuestion(int index) => _questions[index].que;
  bool getAnswer(int index) => _questions[index].ans;
  int getBankLength() => _questions.length;
}
