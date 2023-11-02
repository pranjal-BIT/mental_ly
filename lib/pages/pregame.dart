import 'package:flutter/material.dart';

class PregamePage extends StatelessWidget {
  const PregamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mental.ly",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: "Outfit",
                )),
            SizedBox(height: 64),
            SizedBox(
                width: 135,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Play"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
