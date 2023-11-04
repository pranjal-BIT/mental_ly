import 'package:flutter/material.dart';
import 'package:mathe/components/loading_card.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(child: LoadingCard()),
    );
  }
}
