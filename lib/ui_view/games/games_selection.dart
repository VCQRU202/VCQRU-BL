import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/games/runner_games/game_wrapper.dart';
import 'package:vcqru_bl/ui_view/games/tick_tak_to/tick_tak_to.dart';

import '../../providers_of_app/games_providers/runner_games_provider.dart';
import 'game1_snack.dart';
class GameGridScreen extends StatelessWidget {
  final List<String> games = ['Game1', 'Game2', 'Game3', 'Game4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Games'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return GestureDetector(
                  onTap: () {
                    // Update provider state on click
                    context.read<RunnerGameProvider>().selectGame(game);
                    //


                    if(index==0){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GamesSnack()));
                    }
                    if(index==1){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GameWrapper()));
                    }
                    if(index==2){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DicePage()));
                    }

                  },
                  child: Card(
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        game,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}