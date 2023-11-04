import 'package:flutter/material.dart';
import 'package:mathe/components/postgame_card.dart';

class PostgamePage extends StatelessWidget {
  const PostgamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: PostGameCard(),
      )
    );
  }
}