import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PregamePage extends StatelessWidget {
  const PregamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
              ),
              IconButton(
                onPressed: () {
                  
                },
                icon: Icon(
                  Icons.music_note,
                  color: Colors.black54,
                ),
              )
            ],
          ),
          SizedBox(height: 256),
          Center(
            child: Text("Mental.ly",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                  fontFamily: "Outfit",
                )),
          ),
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
          Gap(20),
          SizedBox(
              width: 135,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share),
                    Gap(8),
                    Text("Share"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF66B3E0),
                ),
              )),
        ],
      ),
    );
  }
}
