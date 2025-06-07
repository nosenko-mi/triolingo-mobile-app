import 'package:flutter/material.dart';
import 'package:triolingo/app/app.dart';

class ResultsPageState extends State<ResultsPage> {

  String stringResult = '';
  double percentResult = 0.0;

@override
  void didChangeDependencies() {
    Map<int, bool> answers = ModalRoute.of(context)?.settings.arguments as Map<int, bool>;

    int count = answers.length;
    int rightCount = 0;
    for (var isRight in answers.values) {
      if(isRight) rightCount++;
    }
    percentResult = ((rightCount / count) * 100).roundTo(2);

    if (percentResult < 25) {
      stringResult = textResultVeryBad;
    } else if (percentResult >= 25 && percentResult < 50) {
      stringResult = textResultBad;
    } else if (percentResult >= 50 && percentResult < 75) {
      stringResult = textResultGood;
    } else if (percentResult >= 75 && percentResult < 100) {
      stringResult = textResultVeryGood;
    } else if (percentResult == 100) {
      stringResult = textResultIdeal;
    }

    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top:  30),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stringResult,
                    style: const TextStyle(
                        fontSize: 57,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 70,
                  ),
                  Text(
                    '$percentResult%',
                    style: const TextStyle(fontSize: 37, color: Colors.black),
                  )
                ],
              ),
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    textRogerThat,
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
      )),
    );
  }
}
