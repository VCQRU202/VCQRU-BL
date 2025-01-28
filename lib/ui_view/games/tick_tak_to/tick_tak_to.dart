import 'dart:math';

import 'package:flutter/material.dart';
class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftdicen = 6;
  int rightdicen = 6;
  String winner = '';
  int scorePlayer1 = 0;
  int scorePlayer2 = 0;

  void rollDice() {
    setState(() {
      leftdicen = Random().nextInt(6) + 1;
      rightdicen = Random().nextInt(6) + 1;

      if (leftdicen > rightdicen) {
        winner = 'Player 1 Wins!';
        scorePlayer1++;
      } else if (rightdicen > leftdicen) {
        winner = 'Player 2 Wins!';
        scorePlayer2++;
      } else {
        winner = "It's a Draw!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Player 1', style: TextStyle(fontSize: 24, color: Colors.white)),
                  Image.asset('assets/dice$leftdicen.png', height: 100, width: 100),
                  Text('Score: $scorePlayer1', style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  Text('Player 2', style: TextStyle(fontSize: 24, color: Colors.white)),
                  Image.asset('assets/dice$rightdicen.png', height: 100, width: 100),
                  Text('Score: $scorePlayer2', style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: rollDice,
            child: Text('Roll Dice'),
          ),
          SizedBox(height: 20),
          Text(winner, style: TextStyle(fontSize: 24, color: Colors.yellow)),
        ],
      ),
    );
  }
}