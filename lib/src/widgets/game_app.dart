//import 'package:basic/play_session/game_widget.dart';
import 'package:alien_invasion/app_lifecycle/app_lifecycle.dart';
import 'package:alien_invasion/src/alien_invasion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame/game.dart';

// import '../../app_lifecycle/app_lifecycle.dart';
// import '../../audio/audio_controller.dart';
// import '../../player_progress/player_progress.dart';
// import '../../router.dart';
// import '../../settings/settings.dart';
import '../../style/palette.dart';


class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final AlienInvasion game;

  @override
  void initState() {
    super.initState();
    game = AlienInvasion();    
  }

  @override
  Widget build(BuildContext context) {
    
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: ((context) => Palette())),
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();
          
            return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.darkPen,
                background: palette.backgroundMain,  
              )
            ),
            home:Scaffold(
              body: SafeArea(
                child: GameWidget(
                  game: game,
                ),
              )
            ),
                  );
          }
        ),
      ),
      
    );
   }
}