import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mathe/constants.dart';
import 'package:mathe/pages/pregame.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// Card to be shown in the End Screen

class PostGameCard extends StatefulWidget {
  const PostGameCard({super.key, required this.state});
  final String state;

  @override
  State<PostGameCard> createState() => _PostGameCardState();
}

class _PostGameCardState extends State<PostGameCard> {
  late io.Socket socket;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFD3BC8D),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You ${widget.state}",
                style: const TextStyle(height: 1.2, fontSize: 48),
              ),
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 135,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF66B3E0)),
                      child: const Text("Rematch"),
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    width: 135,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: () {
                          socket = io.io(IP, <String, dynamic>{
                            "transports": ["websocket"],
                            "autoConnect": false
                          });
                          socket.dispose();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PregamePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                        ),
                        child: const Text("Play")),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
