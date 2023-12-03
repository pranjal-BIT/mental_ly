import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mathe/components/loading_card.dart';
import 'package:mathe/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'new_ingame.dart';

// This page handles the matchmaking process.

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  // Declarations
  late io.Socket socket;
  late String room;
  late List<Map> _list;


  // Code to run on initialization
  @override
  void initState(){
    super.initState();
    match();
  }
  
  void match(){
    // Establish connection with server through websockets
    socket = io.io(IP, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket.connect();
    // Emit event for matchmaking
    socket.emit("matchmaking");

    // Listen for matched event
    socket.on("matched", (data) => {room = json.decode(data)["room"], print(room)});

    // Listen for data event ( Contains questions and answers)
    socket.on(
        "data",
            (data) =>
        {_list = json.decode(data).cast<Map>(), print(_list), gotoGame()});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(child: LoadingCard(),),
      
    );

  }
  gotoGame() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewInGamePage(list: _list)),
    );
  }
}
