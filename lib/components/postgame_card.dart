import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PostGameCard extends StatefulWidget {
  const PostGameCard({super.key});

  @override
  State<PostGameCard> createState() => _PostGameCardState();
}

class _PostGameCardState extends State<PostGameCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFD3BC8D),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You Won",
                style: TextStyle(height: 1.2, fontSize: 48),
              ),
              Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 135,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Rematch"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF66B3E0)),
                    ),
                  ),
                  Gap(20),
                  SizedBox(
                    width: 135,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Play"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                        )),
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
