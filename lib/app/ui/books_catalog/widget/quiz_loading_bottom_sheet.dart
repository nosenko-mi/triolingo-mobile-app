import 'package:flutter/material.dart';
import 'package:triolingo/app/app.dart';

class QuizLoadingBottomSheet extends StatelessWidget {
  const QuizLoadingBottomSheet(
      {super.key});


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
                Text(
                  textPleaseWait,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  textQuizBeenLoading,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),)
            
          ],
        ),
      ),
    );
  }
}
