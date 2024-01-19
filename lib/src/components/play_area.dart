
import 'package:alien_invasion/src/alien_invasion.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class PlayArea extends RectangleComponent 
  with HasGameRef<AlienInvasion>
{
  PlayArea()
    : super(
      paint: Paint()..color = const Color(0xFF0000FF),
      children: [RectangleHitbox()]
    );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}