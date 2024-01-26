
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'dart:math' as math;

import '../settings/components_settings.dart';
import 'package:alien_invasion/src/components/components.dart';

enum PlayState { welcome, playing, gameOver, win, pause }

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

  late PlayState _playState;
  PlayState get playState => _playState;
  
  set playState(PlayState playState) {
    _playState = playState;

    switch (playState) 
    {
      case PlayState.welcome:
      case PlayState.gameOver:      
      case PlayState.pause:
      case PlayState.win:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.win.name);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;   
  }

  @override
  void onTap()
  {
    super.onTap();
    startGame();
  }

  void startGame() 
  {
    if(playState == PlayState.playing) return;

    world.removeAll(world.children.query<Player>());
    world.removeAll(world.children.query<Alien>());
    world.removeAll(world.children.query<Bullet>());

    playState = PlayState.playing;

    world.add(Player(
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
      RawKeyEvent event, 
      Set<LogicalKeyboardKey> keysPressed) 
  {
    super.onKeyEvent(event, keysPressed);

    final isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown && !event.repeat) {   
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
        case LogicalKeyboardKey.keyA:
          world.children.query<Player>().first.moveBy(-playerStep);
        case LogicalKeyboardKey.arrowRight:
        case LogicalKeyboardKey.keyD:
          world.children.query<Player>().first.moveBy(playerStep);
        case LogicalKeyboardKey.space:
          world.children.query<Player>().first.shot();
        case LogicalKeyboardKey.enter:
        //startGame();
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
