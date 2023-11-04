import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mathe/components/scoreboard.dart';

class IngamePage extends StatelessWidget {
  const IngamePage({super.key});

  final question = "2 + 2 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(height: 64),
          ScoreBoardRow(),
          Gap(200),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(question,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    fontFamily: "Outfit",
                  )),
              Container(
                margin: EdgeInsets.all(40),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Colors.black54,
                      ),
                      //textAlign: TextAlign.center,
                    ),

                    //labelText: 'Answer',
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
