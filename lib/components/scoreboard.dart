import 'package:flutter/material.dart';

class ScoreBoardRow extends StatefulWidget {
  const ScoreBoardRow({super.key});

  @override
  State<ScoreBoardRow> createState() => _ScoreBoardRowState();
}

class _ScoreBoardRowState extends State<ScoreBoardRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              "Player 1",
              style: TextStyle(fontSize: 24, color: Colors.black54),
            ),
            Text("Score: 0")
          ],
        ),
        Column(
          children: [
            Text("Player 2", style: TextStyle(fontSize: 24,color: Colors.black54),),
            Text("Score: 0")
          ],
        ),
      ],
    );
  }
}
