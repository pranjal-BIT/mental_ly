import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathe/components/num_pad.dart';
import 'package:mathe/components/scoreboard.dart';
import 'package:mathe/constants.dart';
import 'package:mathe/pages/postgame.dart';
import 'package:mathe/themes/light_text_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

class NewInGamePage extends StatefulWidget {
  const NewInGamePage({super.key, required this.list});
  final List<Map> list;

  @override
  State<NewInGamePage> createState() => _NewInGamePageState();
}

class _NewInGamePageState extends State<NewInGamePage> {
  late SharedPreferences prefs;
  late io.Socket socket;
  late String _gamertag = "Player 1";
  bool isFirst = true;
  String myData = "";
  String oppData = "";
  int scoreCount = 0;
  late String userQuestion;
  int question = 0;
  double _barWidth = 1.0;
  String oppTag = "Player 2";
  int oppScore = 0;
  bool last = false;

  // For timer bar
  void decrement(value) {
    setState(() {
      if (_barWidth - value > 0) {
        _barWidth -= value;
      } else {
        _barWidth = 0;
      }
    });
  }

  void resetBarWidth() {
    _barWidth = 1.0;
  }

  // Initializing timers
  /* timer : for autosubmit
  *  timer2 : for bottom timer*/
  Timer timer = Timer(const Duration(milliseconds: 1), () {});
  late Timer timer2;

  // Numberpad
  List<dynamic> numberPad = [
    Text("7", style: lightnumTextTheme),
    Text("8", style: lightnumTextTheme),
    Text("9", style: lightnumTextTheme),
    const Icon(Icons.delete),
    Text("4", style: lightnumTextTheme),
    Text("5", style: lightnumTextTheme),
    Text("6", style: lightnumTextTheme),
    const Icon(Icons.keyboard_backspace),
    Text("1", style: lightnumTextTheme),
    Text("2", style: lightnumTextTheme),
    Text("3", style: lightnumTextTheme),
    const Icon(Icons.keyboard_return),
    Text("0", style: lightnumTextTheme),
  ];

  String userAnswer = '';

  @override
  void initState() {
    // establishing socket connection and preparing preferences
    connect();
    preppref();

    // resetting barwidth and calling new question
    _barWidth = 1.0;
    newQuestion();

    // Creating periodic timer for timer bar
    timer2 = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      decrement(0.01);
    });

    // Listen for done and gamedata event from server

    socket.on("done", (data) => {isFirst = false, print(isFirst)});
    socket.on(
        "gamedata",
        (data) => {
              setState(() {
                oppTag = jsonDecode(data)["gamertag"];
                oppScore = jsonDecode(data)["score"];
              })
            });

    // Emit gamedata event for initialization

    socket.emit(
        "gamedata", jsonEncode({"gamertag": _gamertag, "score": scoreCount}));

    // Check for show event to show result

    socket.on("show", (data) => {print("showresult"), gotoResult()});

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timer2.cancel();
    socket.dispose();
    super.dispose();
  }

  void connect() {
    socket = io.io(IP, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket.connect();
  }

  Future<void> preppref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _gamertag = (prefs.getString("gamertag"))!;
    });
  }

  // TODO : refactor to lowerCamelCase
  void ButtonTapped(Object button) {
    setState(() {
      if (button is Text && userAnswer.length < 3) {
        userAnswer = userAnswer + button.data.toString();
        HapticFeedback.lightImpact();
      } else if (button.toString() == "Icon(IconData(U+0E35A))") {
        //Check Answer
        checkResult();
        HapticFeedback.mediumImpact();
      } else if (button.toString() == "Icon(IconData(U+0E1B9))") {
        //Clear
        userAnswer = '';
        HapticFeedback.heavyImpact();
      } else if (button.toString() == "Icon(IconData(U+0E357))" &&
          userAnswer.isNotEmpty) {
        HapticFeedback.mediumImpact();
        //Backspace
        userAnswer = userAnswer.substring(0, userAnswer.length - 1);
      } else {
        HapticFeedback.heavyImpact();
      }
    });
  }

  void checkResult() {
    timer.cancel();
    resetBarWidth();
    int answer = userAnswer.isNotEmpty ? int.parse(userAnswer) : 0;
    HapticFeedback.lightImpact();
    userAnswer = '';
    if (answer == widget.list[question - 1]["answer"] as int) {
      //Correct
      if (!last) {
        scoreCount += 10;
      }

      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Card(
                color: const Color(0xFFE59E6D),
                child: Center(
                  child: Text(
                    "Correct",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 1), () {
        newQuestion();
        Navigator.of(context).pop();
        resetBarWidth();
      });

      //generateQuestion();
    } else {
      //Wrong

      HapticFeedback.heavyImpact();
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Card(
                color: const Color(0xFFE59E6D),
                child: Center(
                  child: Text(
                    "Wrong Answer",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
        newQuestion();
      });
    }
  }

  var randomNumber = Random();

  newQuestion() {
    // check for last question
    if (question == 5) {
      print(scoreCount);
      timer.cancel();
      timer2.cancel();
      if (isFirst) {
        socket.emit(
            "done", jsonEncode({"gamertag": _gamertag, "score": scoreCount}));
      } else {
        socket.emit("show");
        gotoResult();
      }
      last = true;
      socket.emit(
          "gamedata", jsonEncode({"gamertag": _gamertag, "score": scoreCount}));
    } else {
      setState(() {
        userQuestion = widget.list[question++]["question"];
      });

      timer.cancel();
      socket.emit("gamedata",
          json.encode({"gamertag": _gamertag, "score": scoreCount}));
      timer = Timer(const Duration(seconds: 10), () {
        checkResult();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // appBar: AppBar(
        //   backgroundColor: Color(0xFFE59E6D),
        //   title: Center(
        //       child: Text(
        //     "Ingame",
        //   )),
        //   elevation: 0,
        // ),
        body: Column(children: [
          //Score(Probably in AppBar)

          //Level Progress
          Container(
            height: 160,
            color: const Color(0xFFE59E6D),
          ),
          //Question
          Expanded(
              child: Container(
            color: const Color(0xFFEEE1C6),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userQuestion,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFE3D4AD)),
                  child: Center(
                    //padding: const EdgeInsets.fromLTRB(8, 20, 16, 0),
                    child: Text(
                      userAnswer,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )),
          )),
          //NumPad
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: numberPad.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: index == 11 ? 160 : 80,
                      height: index == 11 ? 80 : 80,
                      child: numPad(
                          child: numberPad[index],
                          onTap: () {
                            ButtonTapped(numberPad[index]);
                          }),
                    );
                  },
                ),
              )),
        ]),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            height: 10.0,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _barWidth,
                child: Container(
                    decoration: const BoxDecoration(color: Colors.white)))),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: ScoreBoardRow(
          myScore: scoreCount,
          myTag: _gamertag,
          yourScore: oppScore,
          yourTag: oppTag,
        ),
      )
    ]);
  }

  gotoResult() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PostgamePage(myScore: scoreCount, yourScore: oppScore),
        ));
  }
}
