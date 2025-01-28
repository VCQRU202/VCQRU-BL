import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';
import 'endless_runner.dart';
import 'game_win_dialog.dart';

/// This widget defines the properties of the game screen.
///
/// It mostly sets up the overlays (widgets shown on top of the Flame game) and
/// the gets the [AudioController] from the context and passes it in to the
/// [EndlessRunner] class so that it can play audio.
class GameScreen extends StatefulWidget {
  const GameScreen({required this.level, super.key});

  final GameLevel level;

  static const String winDialogKey = 'win_dialog';
  static const String backButtonKey = 'back_buttton';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isLandscape = true;

  @override
  void initState() {
    super.initState();
    _setInitialOrientation();
  }

  void _setInitialOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void _toggleOrientation() {
    if (isLandscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    setState(() {
      isLandscape = !isLandscape;
    });
  }

  @override
  void dispose() {
    // Reset to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();

    return Scaffold(
      body: GameWidget<EndlessRunner>(
        key: const Key('play session'),
        game: EndlessRunner(
          level: widget.level,
          playerProgress: context.read<PlayerProgress>(),
          audioController: audioController,
        ),
        overlayBuilderMap: {
          GameScreen.backButtonKey: (BuildContext context, EndlessRunner game) {
            return Positioned(
              top: 20,
              right: 10,
              child: Row(
                children: [
                  NesButton(
                    type: NesButtonType.normal,
                    onPressed: _toggleOrientation,
                    child: Icon(
                      isLandscape
                          ? Icons.screen_lock_rotation
                          : Icons.screen_rotation,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  NesButton(
                    type: NesButtonType.normal,
                    onPressed: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                      GoRouter.of(context).pop();
                    },
                    child: NesIcon(iconData: NesIcons.leftArrowIndicator),
                  ),
                ],
              ),
            );
          },
          GameScreen.winDialogKey: (BuildContext context, EndlessRunner game) {
            return GameWinDialog(
              level: widget.level,
              levelCompletedIn: game.world.levelCompletedIn,
            );
          },
        },
      ),
    );
  }
}
