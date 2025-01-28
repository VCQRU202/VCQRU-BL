import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/games_providers/game1_snack_provider.dart';
 // Import your provider class

class GamesSnack extends StatelessWidget {
  const GamesSnack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            final gameProvider = Provider.of<GameProvider>(context, listen: false);
            if (gameProvider.direction != Direction.up && details.delta.dy > 0) {
              gameProvider.setDirection(Direction.down);
            }
            if (gameProvider.direction != Direction.down && details.delta.dy < 0) {
              gameProvider.setDirection(Direction.up);
            }
          },
          onHorizontalDragUpdate: (details) {
            final gameProvider = Provider.of<GameProvider>(context, listen: false);
            if (gameProvider.direction != Direction.left && details.delta.dx > 0) {
              gameProvider.setDirection(Direction.right);
            }
            if (gameProvider.direction != Direction.right && details.delta.dx < 0) {
              gameProvider.setDirection(Direction.left);
            }
          },
          child: Consumer<GameProvider>(
            builder: (context, gameProvider, child) {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 760,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 20,
                ),
                itemBuilder: (context, index) {
                  if (gameProvider.snakePosition.contains(index)) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight:Radius.circular(10),
                        ),
                          color: Colors.white
                      ),

                    );
                  }
                  if (index == gameProvider.foodLocation) {
                    return Container(color: Colors.red);
                  }
                  return Container(color: Colors.black);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return FloatingActionButton(
            onPressed: gameProvider.start ? null : () => gameProvider.startGame(),
            child: gameProvider.start
                ? Text((gameProvider.snakePosition.length - 3).toString())
                : const Text('Start'),
          );
        },
      ),
    );
  }
}
