import 'package:flutter/material.dart';
import 'package:triolingo/app/app.dart';

class AnswerBottomSheet extends StatelessWidget {
  const AnswerBottomSheet(
      {super.key, required this.isCorrect, required this.onNextPressed});

  final bool isCorrect;
  final VoidCallback onNextPressed;

  Text _decideMainText() {
    String text;
    Color color;
    if (isCorrect) {
      text = textCorrect;
      color = Colors.black;
    } else {
      text = textIncorrect;
      color = Colors.red;
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _decideDescriptionText() {
    String text;
    Color color;
    if (isCorrect) {
      text = textCorrectExplanation;
      color = Colors.black;
    } else {
      text = textIncorrectExplanation;
      color = Colors.red;
    }
    return Text(
      text,
      style: TextStyle(fontSize: 20, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _decideMainText(),
                const SizedBox(
                  height: 8,
                ),
                _decideDescriptionText(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onNextPressed();
                  },
                  child: const Text(
                    textNext,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
