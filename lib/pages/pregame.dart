import 'package:mathe/auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mathe/constants.dart';
import 'package:mathe/pages/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:lottie/lottie.dart';

class PregamePage extends StatefulWidget {
  const PregamePage({super.key});

  @override
  State<PregamePage> createState() => _PregamePageState();
}

class _PregamePageState extends State<PregamePage> {
  bool isMusicPlaying = false;
  late io.Socket socket;
  late String _playerId;
  late SharedPreferences prefs;
  late AuthService authService;
  String _gamertag = "";

  @override
  void initState() {
    connect();
    preppref();
    super.initState();
    setState(() {});
  }

  void setPlayerID(value) {
    _playerId = value;
  }

  String getPlayerID() {
    return _playerId;
  }

  Future<void> preppref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authService = AuthService(prefs);
    if (authService.isLogged()) {
      print("Already Authenticated !");
    } else {
      authService.authenticate();
    }

    setState(() {
      _gamertag = (prefs.getString("gamertag"))!;
    });
  }

  void connect() {
    socket = io.io(IP, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket.connect();
    socket.onConnect((data) => print("Connected"));
    socket.on("playerId", (data) => {_playerId = data, print(_playerId)});
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
              const Gap(80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      iconSize: 36,
                      icon: const Icon(Icons.person),
                      color: Colors.black54,
                      onPressed: () {}),
                  IconButton(
                      iconSize: 36,
                      color: Colors.black54,
                      icon: isMusicPlaying
                          ? const Icon(Icons.music_note)
                          : const Icon(
                              Icons.music_off,
                            ),
                      onPressed: () {
                        setState(() {
                          isMusicPlaying = !isMusicPlaying;
                        });
                      }),
                ],
              ),
              const SizedBox(height: 256),
              Column(
                children: [
                  const Center(
                    child: Text("Mental.ly",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                          fontFamily: "Outfit",
                        )),
                  ),
                  Center(
                    child: Text(_gamertag,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontFamily: "Outfit",
                        )),
                  )
                ],
              ),
              const SizedBox(height: 64),
              SizedBox(
                  width: 135,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                    ),
                    child: const Text("Play"),
                  )),
              const Gap(20),
              SizedBox(
                  width: 135,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF66B3E0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share),
                        Gap(8),
                        Text("Share"),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
