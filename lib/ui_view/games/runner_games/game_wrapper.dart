import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'player_progress/player_progress.dart';
import 'router.dart';
import 'settings/settings.dart';
import 'style/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'player_progress/player_progress.dart';

import 'style/palette.dart';

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'player_progress/player_progress.dart';
import 'router.dart';
import 'settings/settings.dart';
import 'style/palette.dart';

import 'router.dart';
import 'settings/settings.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class GameWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          // Provider(create: (context) => Palette()),
          // ChangeNotifierProvider(create: (context) => PlayerProgress()),
          // ChangeNotifierProvider(create: (context) => SettingsController()),
          // ChangeNotifierProvider(
          //   create: (context) => AudioController(),
          //   dispose: (context, audio) => audio.dispose(),
          // ),



          Provider(create: (context) => Palette()),
          ChangeNotifierProvider(create: (context) => PlayerProgress()),
          Provider(create: (context) => SettingsController()),
          ProxyProvider2<SettingsController, AppLifecycleStateNotifier,
              AudioController>(
            lazy: false,
            create: (context) => AudioController(),
            update: (context, settings, lifecycleNotifier, audio) {
              audio!.attachDependencies(lifecycleNotifier, settings);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
        ],
        child: ButtonGame(),
      ),
    );
  }
}

class ButtonGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(builder: (context) => MyGame()),
                  );
                },
                child: Text('Play Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  late AudioController audioController;

  @override
  void initState() {
    super.initState();
    audioController = context.read<AudioController>();
    audioController.playGameSound();
  }

  @override
  void dispose() {
    audioController.stopGameSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    return MaterialApp.router(
      title: 'Endless Runner',
      theme: flutterNesTheme().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: palette.seed.color,
          surface: palette.backgroundMain.color,
        ),
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: palette.text.color,
          displayColor: palette.text.color,
        ),
      ),
      routerConfig: router,
    );
  }
}