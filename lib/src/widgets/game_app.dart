//import 'package:basic/play_session/game_widget.dart';
import 'package:alien_invasion/app_lifecycle/app_lifecycle.dart';
import 'package:alien_invasion/settings/components_settings.dart';
import 'package:alien_invasion/src/alien_invasion.dart';
import 'package:alien_invasion/src/widgets/overlay_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame/game.dart';
import 'package:nes_ui/nes_ui.dart';

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
            theme: flutterNesTheme().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.seed.color,
                background: palette.backgroundMain.color,  
              )
            ),
            home:Scaffold(
              body: SafeArea(
                child: FittedBox(
                  child: SizedBox(
                    width: gameWidth,
                    height: gameHeight,
                    
                    child: GameWidget(
                      game: game,
                      overlayBuilderMap: 
                      {
                        PlayState.welcome.name: (context, game) =>
                        const OverlayScreen(
                          title: 'Alien Invasion',
                          subtitle: 'Tap to start',
                        ),
                         PlayState.gameOver.name: (context, game) =>
                        const OverlayScreen(
                          title: 'GAME OVER',
                          subtitle: 'Tap to play again',
                        ),
                         PlayState.win.name: (context, game) =>
                        const OverlayScreen(
                          title: 'YOU WON!!!',
                          subtitle: 'Tap to play again',
                        ),
                         PlayState.pause.name: (context, game) =>
                        const OverlayScreen(
                          title: 'PAUSE',
                          subtitle: 'Tap to continue',
                        ),
                      },
                    ),
                  ),
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