import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IngamePage extends StatelessWidget {
  const IngamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Question",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.primary,
                fontFamily: "Outfit",
              )),
          Container(
            margin: EdgeInsets.all(80),
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
                ),
                //textAlign: TextAlign.center,
                ),
                
                //labelText: 'Answer',
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
