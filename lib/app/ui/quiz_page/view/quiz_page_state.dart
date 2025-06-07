import 'package:flutter/material.dart';
import 'package:triolingo/core/core.dart';
import 'package:triolingo/app/app.dart';

class QuizPageState extends State<QuizPage> {
  late QuizResponse args;
  late List<QuizModel> questions;
  late QuizModel question;

  var questionNumber = 0;

  Map<int, bool> answersMap = {};

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments as QuizResponse;
    questions = args.quizzes;
    question = questions[questionNumber];

    super.didChangeDependencies();
  }

  @override
  void setState(VoidCallback fn) {
    question = questions[questionNumber];

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 33.0, right: 16.0, bottom: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.close, size: 40),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                LinearProgressIndicator(
                  minHeight: 7,
                  backgroundColor: Color.fromARGB(0xFF, 0xD9, 0xD9, 0xD9),
                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(0xFF, 0x06, 0x99, 0x4A)),
                  value: questionNumber / questions.length,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 10),
                Text(
                  questions[questionNumber].message,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                const SizedBox(height: 20),
                for (int i = 0; i < (question.answers?.length ?? 0); i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Color.fromARGB(0xFF, 0x00, 0x66, 0x2F)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        bool isCorrectAnswer =
                            question.answers?[i].correct ?? false;

                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              answersMap[questionNumber] = isCorrectAnswer;
                              return AnswerBottomSheet(
                                isCorrect: isCorrectAnswer,
                                onNextPressed: () {
                                  if ((questionNumber + 1) >=
                                      questions.length) {
                                    Navigator.of(context).pushNamed('/results',
                                        arguments: answersMap);
                                  } else {
                                    questionNumber++;
                                    setState(() {});
                                  }
                                },
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${i + 1}. ${question.answers?[i].text}",
                            style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(0xFF, 0x00, 0x66, 0x2F),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
