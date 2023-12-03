import 'package:flutter/material.dart';
import 'package:mathe/components/postgame_card.dart';

class PostgamePage extends StatefulWidget {
  const PostgamePage({super.key, required this.myScore, required this.yourScore});
  final int myScore;
  final int yourScore;
  @override
  State<PostgamePage> createState() => _PostgamePageState();
}

// Basic page which shows result based off the scores
class _PostgamePageState extends State<PostgamePage> {
  String _state = "";
  @override
  void initState(){
    super.initState();
    if(widget.myScore>widget.yourScore){
      setState(() {
        _state = "Won";
      });
    }
    else if(widget.myScore == widget.yourScore){
      setState(() {
        _state = "Tied";
      });
    }
    else{
      setState(() {
        _state = "Lost";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: PostGameCard(state : _state),
      )
    );
  }
}