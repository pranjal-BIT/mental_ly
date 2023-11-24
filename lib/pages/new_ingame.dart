import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathe/components/num_pad.dart';
import 'package:mathe/themes/light_text_theme.dart';

class NewInGamePage extends StatefulWidget {
  const NewInGamePage({super.key});

  @override
  State<NewInGamePage> createState() => _NewInGamePageState();
}

class _NewInGamePageState extends State<NewInGamePage> {
  List<dynamic> numberPad = [
    Text("7", style: lightnumTextTheme),
    Text("8", style: lightnumTextTheme),
    Text("9", style: lightnumTextTheme),
    Icon(Icons.delete),
    Text("4", style: lightnumTextTheme),
    Text("5", style: lightnumTextTheme),
    Text("6", style: lightnumTextTheme),
    Icon(Icons.keyboard_backspace),
    Text("1", style: lightnumTextTheme),
    Text("2", style: lightnumTextTheme),
    Text("3", style: lightnumTextTheme),
    Icon(Icons.keyboard_return),
    Text("0", style: lightnumTextTheme),
  ];

  String userAnswer = '';

  int number1 = 2;
  int number2 = 4;

  void ButtonTapped(Object button) {
    setState(() {
      if (button is Text && userAnswer.length < 3) {
        userAnswer = userAnswer + button.data.toString();
        HapticFeedback.lightImpact();
      } else if (button.toString() == "Icon(IconData(U+0E35A))") {
        //Check Answer
        checkResult();
        HapticFeedback.mediumImpact();
      } else if (button.toString() == "Icon(IconData(U+0E1B9))") {
        //Clear
        userAnswer = '';
        HapticFeedback.heavyImpact();
      } else if (button.toString() == "Icon(IconData(U+0E357))" &&
          userAnswer.length > 0) {
        HapticFeedback.mediumImpact();
        //Backspace
        userAnswer = userAnswer.substring(0, userAnswer.length - 1);
      } else {
        HapticFeedback.heavyImpact();
      }
    });
  }

  void checkResult() {
    int answer = userAnswer.length > 0 ? int.parse(userAnswer) : 0;
    HapticFeedback.lightImpact();
    userAnswer = '';
    if (answer == number1 + number2) {
      //Correct
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color(0xFFE59E6D),
              content: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Text(
                    "Correct",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                        fontFamily: "Outfit",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          });
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pop();
        newQuestion();
      });

      //generateQuestion();
    } else {
      //Wrong

      HapticFeedback.heavyImpact();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color(0xFFE59E6D),
              content: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Text(
                    "Try Again",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                        fontFamily: "Outfit",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          });
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    }
  }

  var randomNumber = Random();

  newQuestion() {
    setState(() {
      userAnswer = '';
    });

    number1 = randomNumber.nextInt(10);
    number2 = randomNumber.nextInt(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFE59E6D),
      //   title: Center(
      //       child: Text(
      //     "Ingame",
      //   )),
      //   elevation: 0,
      // ),
      body: Column(children: [
        //Score(Probably in AppBar)

        //Level Progress
        Container(
          height: 160,
          color: Color(0xFFE59E6D),
        ),
        //Question
        Expanded(
            child: Container(
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number1.toString() + "+" + number2.toString() + "=",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFE3D4AD)),
                child: Center(
                  //padding: const EdgeInsets.fromLTRB(8, 20, 16, 0),
                  child: Text(
                    userAnswer,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )),
          color: Color(0xFFEEE1C6),
        )),
        //NumPad
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: numberPad.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 1),
                itemBuilder: (context, index) {
                  return Container(
                    width: index == 11 ? 160 : 80,
                    height: index == 11 ? 80 : 80,
                    child: numPad(
                        child: numberPad[index],
                        onTap: () {
                          ButtonTapped(numberPad[index]);
                        }),
                  );
                },
              ),
            )),
      ]),
    );
  }
}
