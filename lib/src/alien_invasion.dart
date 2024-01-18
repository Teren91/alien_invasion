import 'package:basic/src/components/play_area.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flame/components.dart';

import '../settings/components_settings.dart';

class AlienInvasion extends FlameGame
  with HasCollisionDetection, KeyboardEvents, TapDetector
  {
    AlienInvasion() 
      : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        )
      );

    double get width => size.x;
    double get height => size.y;

    @override
    Future<void> onLoad() async {
      super.onLoad();
      
      camera.viewfinder.anchor = Anchor.topLeft;

      world.add(PlayArea());
    }

  }