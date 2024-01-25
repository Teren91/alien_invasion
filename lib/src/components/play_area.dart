
import 'package:alien_invasion/src/alien_invasion.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:alien_invasion/style/palette.dart';

class PlayArea extends RectangleComponent 
  with HasGameRef<AlienInvasion>
{
  PlayArea()
    : super(
      paint: Paint()..color = Palette().backgroundMain.color,
      children: [RectangleHitbox()]
    );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}