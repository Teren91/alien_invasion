import 'package:alien_invasion/src/alien_invasion.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import 'package:alien_invasion/src/components/components.dart';

class Bullet extends RectangleComponent
  with CollisionCallbacks, HasGameReference<AlienInvasion>
{
  Bullet(
  {
    required this.velocity,
    required super.position,
    required super.size,
  })
    : super(
      anchor: Anchor.center,
      children: [RectangleHitbox()] ,
      paint: Paint()
        ..color = Colors.orange[400]!
        ..style = PaintingStyle.fill,
    );

  final Vector2 velocity;

  @override
  void update(double dt)
  {
    super.update(dt);
    position += velocity * dt;
  }

 @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints, PositionComponent other)
  {
    super.onCollisionStart(intersectionPoints, other);

    if(other is PlayArea)
    {
      if(intersectionPoints.first.y <= 0)
      {
        removeFromParent();
        debugPrint('bullet removed');
      }
    }
  }


}