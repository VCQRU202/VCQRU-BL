import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class FortuneWheelExample extends StatefulWidget {
  @override
  _FortuneWheelExampleState createState() => _FortuneWheelExampleState();
}

class _FortuneWheelExampleState extends State<FortuneWheelExample> {
  StreamController<int> selected = StreamController<int>.broadcast();
  int remainingSpins = 3;
  DateTime? lastSpinDate;
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _loadSpinData();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    _spinWheel();
  }

  Future<void> _loadSpinData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    remainingSpins = prefs.getInt('remainingSpins') ?? 3;
    int? lastSpinDateMillis = prefs.getInt('lastSpinDate');
    if (lastSpinDateMillis != null) {
      lastSpinDate = DateTime.fromMillisecondsSinceEpoch(lastSpinDateMillis);
    }
    setState(() {}); // Update UI
  }

  Future<void> _saveSpinData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingSpins', remainingSpins);
    await prefs.setInt('lastSpinDate', DateTime.now().millisecondsSinceEpoch);
  }

  void _spinWheel() {
    remainingSpins = 3;

    if (remainingSpins > 0) {
      DateTime now = DateTime.now();
      if (lastSpinDate == null ||
          lastSpinDate!.day != now.day ||
          lastSpinDate!.month != now.month ||
          lastSpinDate!.year != now.year) {
        remainingSpins = 3; // Reset spins if it's a new day
      }

      setState(() {
        remainingSpins--;
        lastSpinDate = now;
      });
      _saveSpinData(); // Save spin data

      selected.add(Fortune.randomInt(0, items.length));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have no spins remaining for today.')),
      );
    }
  }

  final items = <String>[
    '10 Points',
    '20 Points',
    '30 Points',
    '0 Points',
    '40 Points',
  ];

  final Fitem = <FortuneItem>[
    FortuneItem(
        child: Text('10 Points'),
        style: FortuneItemStyle(
            borderWidth: 3, borderColor: Colors.yellow, color: Colors.cyan)),
    FortuneItem(
        child: Text('20 Points'),
        style: FortuneItemStyle(
            borderWidth: 3,
            borderColor: Colors.yellow,
            color: Colors.purpleAccent)),
    FortuneItem(
        child: Text('30 Points'),
        style: FortuneItemStyle(
            borderWidth: 3, borderColor: Colors.yellow, color: Colors.orange)),
    FortuneItem(
        child: Text('0 Points'),
        style: FortuneItemStyle(
            borderWidth: 3,
            borderColor: Colors.yellow,
            color: Colors.deepPurpleAccent)),
    FortuneItem(
        child: Text('40 Points'),
        style: FortuneItemStyle(
            borderWidth: 3, borderColor: Colors.yellow, color: Colors.green)),
  ];

  @override
  void dispose() {
    _controllerCenter.dispose();
    selected.close();
    super.dispose();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: FortuneWheel(
                  selected: selected.stream,
                  animateFirst: false,
                  items: [for (int i = 0; i < Fitem.length; i++) Fitem[i]],
                  onAnimationEnd: () async {
                    int selectedValue = await selected.stream.first;
                    String result = items[selectedValue];
                    print('Wheel stopped on: $result'); // Debug print
                    await Future.delayed(Duration(seconds: 5));
                    _controllerCenter = ConfettiController(
                        duration: const Duration(
                            milliseconds:
                                200)); // Shorter duration for continuous blasts
                    _controllerCenter.play();

                    print('Showing dialog...'); // Debug print

                    showDialog(
                      context: context,
                      builder: (context) {
                        String message = '';
                        if (result == '10 Points' ||
                            result == '40 Points' ||
                            result == '20 Points' ||
                            result == '30 Points') {
                          message = 'Congratulations! You got $result!';
                        } else if (result == '0 Points') {
                          message = 'Better luck next time!';
                        }

                        return AlertDialog(
                          title: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 20, // Set fixed width
                              height: 20, // Set fixed height
                              child: ConfettiWidget(
                                confettiController: _controllerCenter,
                                blastDirectionality:
                                    BlastDirectionality.explosive,
                                shouldLoop: true,
                                numberOfParticles: 30,
                                // Increase the number of particles
                                emissionFrequency: 0.05,
                                // Increase frequency for more continuous effect
                                colors: [
                                  Colors.green,
                                  Colors.blue,
                                  Colors.pink,
                                  Colors.orange,
                                  Colors.purple,
                                  Colors.yellow,
                                  Colors.purpleAccent,
                                ],
                                createParticlePath: drawStar,
                              ),
                            ),
                          ),
                          content: Text(message),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _controllerCenter
                                    .stop(); // Stop confetti when dialog is closed
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                    print('Dialog shown.'); // Debug print
                  }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _spinWheel,
              child: Text('Spin the Wheel ($remainingSpins spins left)'),
            ),
          ],
        ),
      ),
    );
  }
}
