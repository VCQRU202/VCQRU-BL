import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum Direction { up, down, left, right }

class GameProvider with ChangeNotifier {
  List<int> snakePosition = [24, 44, 64];
  int foodLocation = Random().nextInt(700);
  Direction direction = Direction.down;
  bool start = false;

  List<int> totalSpot = List.generate(760, (index) => index);

  void startGame() {
    start = true;
    snakePosition = [24, 44, 64];
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void updateSnake() {
    switch (direction) {
      case Direction.down:
        if (snakePosition.last > 740) {
          snakePosition.add(snakePosition.last - 760 + 20);
        } else {
          snakePosition.add(snakePosition.last + 20);
        }
        break;
      case Direction.up:
        if (snakePosition.last < 20) {
          snakePosition.add(snakePosition.last + 760 - 20);
        } else {
          snakePosition.add(snakePosition.last - 20);
        }
        break;
      case Direction.right:
        if ((snakePosition.last + 1) % 20 == 0) {
          snakePosition.add(snakePosition.last + 1 - 20);
        } else {
          snakePosition.add(snakePosition.last + 1);
        }
        break;
      case Direction.left:
        if (snakePosition.last % 20 == 0) {
          snakePosition.add(snakePosition.last - 1 + 20);
        } else {
          snakePosition.add(snakePosition.last - 1);
        }
        break;
    }

    if (snakePosition.last == foodLocation) {
      totalSpot.removeWhere((element) => snakePosition.contains(element));
      foodLocation = totalSpot[Random().nextInt(totalSpot.length - 1)];
    } else {
      snakePosition.removeAt(0);
    }
    notifyListeners();
  }

  bool gameOver() {
    final copyList = List.from(snakePosition);
    return snakePosition.length > copyList.toSet().length;
  }

  void setDirection(Direction newDirection) {
    direction = newDirection;
    notifyListeners();
  }
}
