
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import 'dart:math' as math;

import 'package:alien_invasion/src/alien_invasion.dart';
import 'package:alien_invasion/src/components/components.dart';
import 'package:alien_invasion/settings/components_settings.dart';
import 'package:alien_invasion/style/palette.dart';

class Player extends PositionComponent
    with DragCallbacks, HasGameReference<AlienInvasion> {
  Player(
      {required this.cornerRadius,
      required super.position,
      required super.size})
      : super(anchor: Anchor.center, children: [RectangleHitbox()]);

  final Radius cornerRadius;
  final rand = math.Random();
  
  final _paint = Paint()
    ..color = Palette().player.color//Colors.green[300]!
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    //Pinta un rectangulo con bordes redondeados
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size.toSize(), cornerRadius),
      _paint,
    );
  }

  //Crea un efecto de movimiento
  void moveBy(double dx) {
    add(MoveToEffect(
      Vector2(
        (position.x + dx).clamp(width / 2, game.width - width / 2),
        position.y,
      ),
      EffectController(duration: 0.1),
    ));
  }

  void shot() {
    game.world.add(
      Bullet(
        velocity: Vector2(0, -height)
          .normalized()
          ..scale(height * 4),
        position: position.clone() + Vector2(0, -bulletHeight / 2),
        size: Vector2(bulletWidth, bulletHeight),
      ),
    );
    debugPrint('Bullet added from player');
  }
}
