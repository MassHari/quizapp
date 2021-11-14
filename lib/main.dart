import 'package:flutter/material.dart';
import 'package:quizapp/question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
    ),
  );
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> checkAns = [];
  final QuestionBank questionBank = QuestionBank();

  int num = 0;
  int score = 0;
  int click = 1;
  Color colour1 = Colors.grey;
  Color colour2 = Colors.grey;
  int n = 0;
  int attend = 0;

  void check(bool answer) {
    colour1 = true == questionBank.getAnswer(num) ? Colors.green : Colors.red;
    colour2 = false == questionBank.getAnswer(num) ? Colors.green : Colors.red;

    if ((answer == questionBank.getAnswer(num)) && (n < click)) {
      checkAns.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
      attend = attend + 1;
      score = score + 1;
      print(n);
      print(click);
      n = n + 1;
    }
    //else  {
    //   checkAns.add(Icon(
    //     Icons.clear,
    //     color: Colors.red,
    //   ));
    // }
    if ((answer != questionBank.getAnswer(num)) && (n < click)) {
      checkAns.add(Icon(
        Icons.clear,
        color: Colors.red,
      ));
      attend = attend + 1;
      print(n);
      print(click);
      n = n + 1;
    }
  }

  void button() {
    setState(() {
      if (num < questionBank.getBankLength() - 1) {
        num = num + 1;
        click = click + 1;
        colour1 = Colors.grey;
        colour2 = Colors.grey;
      } else {
        Alert(
                context: context,
                title: "Quiz Completed",
                desc: 'Score : $score/4')
            .show();
        score = 0;
        num = 0;
        click = 1;
        n = 0;
        attend = 0;
        colour1 = Colors.grey;
        colour2 = Colors.grey;
        checkAns.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Questions : $attend/4',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 200.0, 10.0, 100.0),
              child: Text(
                questionBank.getQuestion(num),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              color: colour1,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      check(true);
                    });
                  },
                  child: Container(
                    child: Text(
                      'True',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  )),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              color: colour2,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      check(false);
                    });
                  },
                  child: Container(
                    child: Text(
                      'False',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextButton(
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  onPressed: () {
                    button();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                children: checkAns,
              ),
            )
          ],
        ),
      ),
    );
  }
}
