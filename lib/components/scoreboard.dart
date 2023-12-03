import 'package:flutter/material.dart';

// Scoreboard Shown at the top of the screen while in GAME

class ScoreBoardRow extends StatefulWidget {
  const ScoreBoardRow(
      {super.key,
      required this.myScore,
      required this.myTag,
      required this.yourScore,
      required this.yourTag});
  final int myScore;
  final String myTag;
  final int yourScore;
  final String yourTag;
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
              widget.myTag,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text("Score :${widget.myScore}",
                style: const TextStyle(fontSize: 14, color: Colors.black54))
          ],
        ),
        Column(
          children: [
            Text(
              widget.yourTag,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text("Score :${widget.yourScore}",
                style: const TextStyle(fontSize: 14, color: Colors.black54))
          ],
        ),
      ],
    );
  }
}
