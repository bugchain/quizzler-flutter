import 'package:flutter/material.dart';
import 'package:quizzler_flutter/quzz_brain.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MyApp(),
          ),
        ),
      ),
    );
  }
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  QuzzBrain quzzBrain = QuzzBrain();
  List<Icon> scoreKeeper = [];

  @override
  void initState() {
    quzzBrain = QuzzBrain();
    scoreKeeper = [];
    super.initState();
  }

  void addScoreKeeper({bool answer = false}) {
    setState(
      () {
        if (quzzBrain.isFinish()) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Finished!'),
              content: const Text('You\'ve reached the end of the quiz.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );

          quzzBrain.reset();
          scoreKeeper = [];
        } else {
          if (quzzBrain.getCorrectAnswer() == answer) {
            scoreKeeper.add(
              Icon(
                Icons.check,
                color: Colors.green,
              ),
            );
          } else {
            scoreKeeper.add(
              Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
          }
          quzzBrain.nextQuestion();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quzzBrain.getQuestionTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.green.shade100,
                  backgroundColor: Colors.green),
              child: Text(
                'True',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                addScoreKeeper(answer: true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.red.shade100, backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                addScoreKeeper(answer: false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
