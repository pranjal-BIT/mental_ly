import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mathe/pages/loading.dart';

import 'package:lottie/lottie.dart';

class PregamePage extends StatefulWidget {
  const PregamePage({super.key});

  @override
  State<PregamePage> createState() => _PregamePageState();
}

class _PregamePageState extends State<PregamePage> {
  bool isMusicPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void toggleMusic() {
    setState(() {
      isMusicPlaying = !isMusicPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset('assets/Mental_lyBG.json',
                fit: BoxFit.fitHeight, repeat: true),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      iconSize: 36,
                      icon: Icon(Icons.person),
                      color: Colors.black54,
                      onPressed: () {}),
                  IconButton(
                      iconSize: 36,
                      color: Colors.black54,
                      icon: isMusicPlaying
                          ? Icon(Icons.music_note)
                          : Icon(
                              Icons.music_off,
                            ),
                      onPressed: () {
                        setState(() {
                          isMusicPlaying = !isMusicPlaying;
                        });
                      }),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingPage()));
                    },
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
        ],
      ),
    );
  }
}
