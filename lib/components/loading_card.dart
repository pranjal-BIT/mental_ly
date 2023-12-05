import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingCard extends StatefulWidget {
  const LoadingCard({super.key});

  @override
  State<LoadingCard> createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.background,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Lottie.network("https://lottie.host/4031bacb-1b15-4cdc-8339-a109d0ec2c46/FcGijE4kc9.json"), //https://lottie.host/?file=4031bacb-1b15-4cdc-8339-a109d0ec2c46/FcGijE4kc9.json
            Lottie.asset("assets/circle_loader.json"),
            Center(child: Text("Finding another nerd..."))
          ],
        ));
  }
}
