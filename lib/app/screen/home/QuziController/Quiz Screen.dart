import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labquest/app/screen/home/QuziController/QuizController.dart';

import '../../../../controller/homecontroller.dart';



class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final control = Get.find<Homecontroller>(); // Corrected controller name
  int currentQuestionIndex = 0;
  int score = 0;
  bool isQuizCompleted = false;

  void answerQuestion(int score) {
    setState(() {
      this.score += score;
      if (currentQuestionIndex < control.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        isQuizCompleted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: isQuizCompleted
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 20),
            Text(
              'Your Score: $score',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  isQuizCompleted = false;
                });
              },
              child: Text('Restart Quiz'),
            ),
            ElevatedButton(
              onPressed: () {
                // Uncomment this line if you have the Report screen defined.
                // Get.to(() => Report());
              },
              child: Text('View Report'),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              control.questions[currentQuestionIndex]['question'] as String,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          ...(control.questions[currentQuestionIndex]['answers']
          as List<Map<String, Object>>)
              .map((answer) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () => answerQuestion(answer['score'] as int),
                child: Text(answer['text'] as String),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
