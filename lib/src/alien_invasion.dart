import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

import '../settings/components_settings.dart';
import 'package:alien_invasion/src/components/components.dart';

class AlienInvasion extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  AlienInvasion()
      : super(
            camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ));

  double get width => size.x;
  double get height => size.y;

  final rand = math.Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    world.add(Player(
      cornerRadius: const Radius.elliptical(playerHeight, playerWidth),
      position: Vector2(gameWidth / 2, gameHeight - playerHeight),
      size: Vector2(playerHeight, playerWidth),
    ));

    world.addAll([
      for (var i = 0; i < alienArmy; i++)
        for (var j = 1; j <= 5; j++)
          Alien(
            velocity: Vector2(alienVelocity, 0),
            position: Vector2(
              (i + 0.5) * alienWidth + (i + 1) * alienWidth,
              (j + 2.0) * alienHeight + j * (alienWidth / 2),
            ),
            size: Vector2(alienWidth, alienHeight),
            alienMoveToRight: 1.0,
          ),
    ]);
  }



  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
      case LogicalKeyboardKey.keyA:
        world.children.query<Player>().first.moveBy(-playerStep);
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.keyD:
        world.children.query<Player>().first.moveBy(playerStep);
      case LogicalKeyboardKey.space:
        debugPrint('shot');
        world.children.query<Player>().first.shot();
      case LogicalKeyboardKey.enter:
      //startGame();
    }
    return KeyEventResult.handled;
  }
}
